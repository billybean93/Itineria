//
//  ChatView.swift
//  ChatGPTChat
//
//  This code is taken from LiamRMIT created on 26/9/2023
//
//

import SwiftUI
/// A view that provides a chat interface for users to interact with ChatGPT.
///
/// The `ChatView` is a SwiftUI view that enables users to send messages to ChatGPT and receive responses in real-time. It includes features like message history display, scrolling to the latest message, and input handling.
///
/// This view includes:
/// - A **message list** that shows both user and system messages.
/// - A **text input field** where users can enter their queries.
/// - A **send button** that triggers the request to the GPT model.
/// - Automatic scrolling to the latest message.
///
/// Messages are displayed using the `MessageView` component, which handles the formatting of individual chat messages. The view makes asynchronous requests to the OpenAI API to retrieve responses from GPT.
///
/// ## Topics
/// ### Properties
/// - `@State var chatMessages`: An array holding all the chat messages, including both user and system messages.
/// - `@State var message`: The current text that the user is typing, ready to be sent.
/// - `@State var lastMessageID`: The ID of the last message, used for scrolling to the latest message.
/// - `@State var isLoading`: A Boolean value that indicates whether the app is currently waiting for a response from the GPT API.
///
/// ### Functions
/// - `sendMessage()`: Asynchronously handles sending a user message and receiving a response from GPT.
/// - `getOpenAIChatResponse(_:)`: Sends a POST request to the OpenAI API to retrieve a chat response from GPT.
///
/// ### Example Usage
/// ```swift
/// struct ChatView_Previews: PreviewProvider {
///     static var previews: some View {
///         ChatView()
///     }
/// }
/// ```
///
/// ## User Interaction
/// - Users can enter a message in the text field at the bottom of the screen.
/// - Pressing the **send button** (an arrow icon) sends the message to GPT and displays both the user’s message and GPT’s response.
/// - A progress indicator replaces the send button when a message is being processed.
///
/// ## Layout and Structure
/// - The main view is organized in a vertical stack (`VStack`), which contains:
///   - A **title**: "Ask GPT about your next GREAT adventure!".
///   - A **scrollable chat area**: Displays all past messages, and automatically scrolls to the latest one when new messages are added.
///   - A **text field and button area**: The input field for user messages and a send button.
///
struct ChatView: View {
    ///A state variable which holds  the list of messages in the chat. Each message is of type ChatMessage, a custom data model that holds details like message content, ID, creation time, and sender.
    @State private var chatMessages: [ChatMessage] = []
    ///A state variable to store the current message input.
    @State var message: String = ""
    ///A state variable to store the ID of the last message, allowing better navigation to the lattest message.
    @State var lastMessageID: String = ""
    ///A state variable to keep track of the loading response from ChatGPT API
    @State var isLoading = false
    
    ///This is the main view’s layout and structure, built using SwiftUI components.
    var body: some View {
        //  A vertical stack that holds the entire chat interface, which includes the chat history, input field, and send button.
        VStack {
            //  Displays the chat title, “Ask GPT about your next GREAT adventure!”, aligned to the top of the view.
            HStack {
                Text("Ask GPT about your next GREAT adventure!")
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
            }
            //  Allows the chat to scroll to the most recent message automatically when new messages are added.
            ScrollViewReader { proxy in
                ScrollView(.vertical, showsIndicators: false) {
                    
                    //  Efficiently loads and displays chat messages. It iterates through chatMessages and displays each one using the MessageView.
                    LazyVStack {
                        ForEach(chatMessages, id: \.id) { message in
                            MessageView(message: message)
                        }
                    }
                }
                
                //  This modifier listens for changes in the lastMessageID and scrolls the view to the bottom whenever a new message is added, ensuring the user always sees the latest message.
                
                .onChange(of: self.lastMessageID) { id in
                    withAnimation{
                        proxy.scrollTo(id, anchor: .bottom)
                    }
                }
            }
            
            HStack {
                TextField("e.g Interesting places in Melbourne", text: $message) {}
                    .disabled(isLoading)
                    .padding()
                    .background(.gray.opacity(0.4))
                    .cornerRadius(12)
                //  When Button is tapped, triggers the sendMessage() function to send the message asynchronously. While loading, it shows a progress indicator.
                Button{
                    Task {
                        await sendMessage()
                    }
                } label: {
                    if !isLoading {
                        Image(systemName: "arrow.right.circle.fill")
                            .foregroundColor(.blue)
                            .padding(.horizontal, 5)
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                    } else {
                        ProgressView()
                            .foregroundColor(.blue)
                            .padding(.horizontal, 5)
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                    }
                }.disabled(isLoading)
            }
        }
        .padding()
    }
    /// Sends a message asynchronously to the GPT API and updates the chat view.
    ///
    /// - Adds the user's message to the chat.
    /// - Sends the message to the OpenAI API for a response.
    /// - Appends the GPT response to the chat and resets the input field.

    func sendMessage() async {
        // early return if message is empty
        guard message != "" else {return}
        
        // set loading state
        isLoading = true
        
        // create a message object and store it to display
        let userMessage = ChatMessage(id: UUID().uuidString, content: message, createdAt: Date(), sender: .user)
        chatMessages.append(userMessage)
        lastMessageID = userMessage.id
        
        // create the body for the request
        let currentMessages: [Message] = chatMessages.map { Message(role: ($0.sender == .user) ? "user" : "system", content: $0.content) }
        let body = OpenAIChatBody(model: "gpt-3.5-turbo", messages: currentMessages)
        
        guard let openAIResult = await getOpenAIChatResponse(body)
        else {
            isLoading = false
            return
        }
        
        // get the text response and create a new message from it
        guard let textResponse = openAIResult.choices.first?.message.content.trimmingCharacters(in: .whitespacesAndNewlines.union(.init(charactersIn: "\""))) else {return}
        
        // create the message
        let systemMessage = ChatMessage(id: openAIResult.id, content: textResponse, createdAt: Date(), sender: .system)
        
        // append the latest message and update last id
        chatMessages.append(systemMessage)
        lastMessageID = systemMessage.id
        
        // reset message after send
        message = ""
        isLoading = false
    }
    
    /// Sends a POST request to OpenAI’s API and decodes the response.
        ///
        /// - Parameter body: The `OpenAIChatBody` containing the user and system messages for the request.
        /// - Returns: An optional `OpenAIResult` containing the response, or nil if the request fails.
    
    func getOpenAIChatResponse(_ body: OpenAIChatBody) async -> OpenAIResult? {
        // create a messsage request with the bearer token in the header
        var request = URLRequest(url: URL(string: "https://api.openai.com/v1/chat/completions")!)
        request.addValue("Bearer \(Constants.OPEN_API_KEY)", forHTTPHeaderField: "Authorization")
        
        // set the content type to json
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // encode the body as json
        let jsonData = try? JSONEncoder().encode(body)
        
        // set request to post type and set the body
        request.httpMethod = "POST"
        request.httpBody = jsonData
        
        // call the api and decode the response
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            return try JSONDecoder().decode(OpenAIResult.self, from: data)
        } catch {
            print("Unable to send message or decode response: \(error)")
            return nil
        }
        
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
