//
//  MessageView.swift
//  ChatGPTChat
//  This code is taken from LiamRMIT created on 26/9/2023
//

import SwiftUI
/// ## Overview
/// A view that displays a chat message in a horizontal layout, formatting based on the message sender.
///
/// The `MessageView` struct is a SwiftUI view that visually represents a chat message. It differentiates
/// between messages sent by the user and the system, and adjusts the alignment, color, and background accordingly.
///
/// - If the message is from the user, it is aligned to the right, and displayed with white text on a blue background.
/// - If the message is from the system, it is aligned to the left, and displayed with default text color on a gray background.
/// - Both message types have padding and rounded corners for improved visual appeal.
///
/// This view is ideal for use in chat-based applications, providing a simple yet flexible way to render messages.
///
/// ## Topics
/// ### Properties
/// - `message`: The `ChatMessage` object that provides the content and sender information to this view.
///
/// ### Example Usage
/// ```swift
/// struct ChatMessage {
///     enum Sender {
///         case user
///         case system
///     }
///     var id: String
///     var content: String
///     var createdAt: Date
///     var sender: Sender
/// }
///
/// let userMessage = ChatMessage(id: "1", content: "Hi what is your name?", createdAt: Date.now, sender: .user)
/// let systemMessage = ChatMessage(id: "2", content: "Hello, I am ChatGPT.", createdAt: Date.now, sender: .system)
///
/// var body: some View {
///     VStack {
///         MessageView(message: userMessage)
///         MessageView(message: systemMessage)
///     }
/// }
/// ```
///
/// ## Previews
/// The preview provides a visual example of how the `MessageView` looks for both user and system messages.
///
/// ```swift
/// struct MessageView_Previews: PreviewProvider {
///     static let userMessage = ChatMessage(id: "1", content: "Hi what is your name?", createdAt: Date.now, sender: .user)
///     static let systemMessage = ChatMessage(id: "2", content: "Hello, I am ChatGPT.", createdAt: Date.now, sender: .system)
///
///     static var previews: some View {
///         MessageView(message: userMessage)
///             .previewDisplayName("User Message")
///         MessageView(message: systemMessage)
///             .previewDisplayName("System Message")
///     }
/// }
/// ```
struct MessageView: View {
    /// This property holds the message data including its content, sender, and timestamp
    var message: ChatMessage
    
    var body: some View {
        HStack{
            if message.sender == .user{Spacer()}
            Text(message.content)
                .foregroundColor(message.sender == .user ? .white : nil)
                .padding()
                .background(message.sender == .user ? .blue : .gray.opacity(0.4))
                .cornerRadius(24)
            if message.sender == .system{Spacer()}
        }
    }
}

struct MessageView_Previews: PreviewProvider {
    static let userMessage = ChatMessage(id: "1", content: "Hi what is your name?", createdAt: Date.now, sender: .user)
    static let systemMessage = ChatMessage(id: "2", content: "Hello, I am ChatGPT.", createdAt: Date.now, sender: .system)
    
    static var previews: some View {
        MessageView(message: userMessage)
            .previewDisplayName("User Message")
        MessageView(message: systemMessage)
            .previewDisplayName("System Message")
    }
}
