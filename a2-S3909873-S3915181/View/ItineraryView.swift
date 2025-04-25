//
//  ItineraryView.swift
//  a1-S3909873-S3915181
//
//  Created by Daniel La on 19/8/2024.
//
import SwiftUI
import SwiftData

/// 'ItineraryView' provides a user interface for entering details about their trips. This incldes trip name, description and dates. After, they can create their itinerary and proceed to add planners to organise their trips
struct ItineraryView: View {
    /// A state variable that holds the name of the trip that is input by the user
    @State private var name = ""
    /// A state variable that holds the description of the trip that is input by the user
    @State private var description = ""
    /// A state variable that holds the start date of the trip that is input by the user
    @State private var startDate = Date()
    /// A state variable that holds the end date of the trip that is input by the user
    @State private var endDate = Date()
    /// A state variable that controls whether the ``MenuView`` is presented or not
    @State private var showMenuView = false
    /// A state variable to track the rotation animation
    @State var rotate = false
    /// A state variable which is a string that holds the description of the trip retrieved from `UserDefaults`
    @State var tripDescription: String = UserDefaults.standard.string(forKey: "DESCRIPTION_KEY") ?? "" //(Indently 2021)
    /// A state that holds the current itinerary model
    @State private var currentItinerary = ItineraryModel(tripName: "", tripStartDate: Date(), tripEndDate: Date(), tripDescription: "", items: [])
    /// An environmental variable that gives access to the data model context
    @Environment(\.modelContext) var modelContext
    /// A query variable that fetches the Itinerary Model Data
    @Query var itineraryItem: [ItineraryModel]
    /// A state variable to track whether the long press gesture is active or not
    @State private var longPressActive: Bool = false // (iOS Academy 2021 & ByungwookAn 2024)
    /// A state variable that tracks the rotation angle of the rotating gesture
    @State private var rotationAngle =  Angle(degrees: 0.0) // (iOS Academy 2021 & ByungwookAn 2024)
    
    var body: some View {
        // Wrap the entire view in NavigationView
        NavigationView {
            VStack {
                VStack {
                    VStack(spacing: 20) {
                        // Title
                        Text("Create a Trip")
                            .font(.system(.title, design: .rounded))
                    }
                    
                    VStack {
                        // Input fields for itinerary
                        HStack {
                            VStack {
                                Text("Date")
                                    .font(.system(size: 13))
                                Image(systemName: "calendar")
                                    .font(.system(size: 24))
                                    .foregroundColor(Color(hue: 0.925, saturation: 0.975, brightness: 0.978))
                            }
                            Spacer()
                            VStack {
                                Text("Start Date")
                                    .foregroundStyle(Color.blue)
                                    .shadow(radius: 5)
                                DatePicker("", selection: $startDate, displayedComponents: .date)
                                    .scaleEffect(0.8)
                                    .frame(width: 100, height: 35)
                                    .padding(5)
                            }
                            Spacer()
                            Image(systemName: "arrow.right")
                                .bold()
                                .padding(.top, 30)
                                .padding(.horizontal, 5)
                            Spacer()
                            VStack {
                                Text("End Date")
                                    .foregroundStyle(Color.blue)
                                    .shadow(radius: 5)
                                DatePicker("", selection: $endDate, in: startDate..., displayedComponents: .date)
                                    .scaleEffect(0.8)
                                    .frame(width: 100, height: 35)
                                    .padding(5)
                            }
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal, 15)
                        
                        Divider()
                        
                        HStack {
                            VStack {
                                Text("Name")
                                    .font(.system(size: 13))
                                Image(systemName: "pencil.and.scribble")
                                    .font(.system(size: 24))
                                    .foregroundColor(Color(hue: 0.925, saturation: 0.975, brightness: 0.978))
                            }
                            TextField("Name your trip", text: $name)
                                .padding(.horizontal, 15)
                                .foregroundStyle(Color.gray)
                                .opacity(0.8)
                            Spacer()
                        }
                        .padding(.vertical, 15)
                        .padding(.horizontal, 15)
                        
                        Divider()
                        
                        HStack {
                            VStack {
                                Text("Notes")
                                    .font(.system(size: 13))
                                Image(systemName: "note.text")
                                    .font(.system(size: 24))
                                    .foregroundColor(Color(hue: 0.925, saturation: 0.975, brightness: 0.978))
                            }
                            TextField("Add a description", text: $description)
                                .padding(.horizontal, 15)
                                .foregroundStyle(Color.gray)
                                .opacity(0.8)
                            Spacer()
                        }
                        .padding(.vertical, 20)
                        .padding(.horizontal, 15)
                        
                    }
                    .overlay(RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.gray, lineWidth: 2)
                        .opacity(0.2)
                        .padding(0))
                    Spacer()
                    
                    // Custom Image layout
                    ZStack {
                        RadialImageLayout {
                            ForEach(0..<1, id: \.self) { item in
                                ImageStyle(imageName: "japan")
                                ImageStyle(imageName: "china")
                                ImageStyle(imageName: "paris")
                                ImageStyle(imageName: "america")
                                ImageStyle(imageName: "sydney")
                            }
                            // Rotation effect for images itself
                            .rotationEffect(Angle(degrees: rotate ? 360 : 0))
                            .animation(Animation.linear(duration: 20).repeatForever(autoreverses: false), value: rotate)
                        }
                    }
                    // Rotation effect for all images & Long Press Rotation Gesture
                    // (iOS Academy 2021 & ByungwookAn 2024)
                    .rotationEffect(Angle(degrees: rotate ? 360 : 0))
                    .animation(Animation.linear(duration: 60).repeatForever(autoreverses: false), value: rotate)
                    .rotationEffect(rotationAngle) // Apply rotation angle here
                    .gesture(
                            RotationGesture()
                            .onChanged { angle in
                                rotationAngle = angle
                                }
                                )
                                .simultaneousGesture(
                                    LongPressGesture(minimumDuration: 1.0)
                                        .onChanged { _ in
                                            longPressActive = true
                                        }
                                        .onEnded { _ in
                                            longPressActive = false
                                        }
                                )
                }
                .onAppear {
                    rotate.toggle()
                }
                
                //Button that creates the itinerary and navigates to another view to add planner items
                Button(action: {
                    showMenuView = true
                    createItinerary()
                    UserDefaults.standard.set(description, forKey: "DESCRIPTION_KEY")
                    tripDescription = description

                }) {
                    HStack {
                        Text("Create Trip")
                        Image(systemName: "airplane")
                    }
                    .padding(20)
                    .padding(.horizontal, 30)
                    .background(Color(hue: 0.4, saturation: 0.96, brightness: 0.794))
                    .foregroundStyle(.white)
                    .clipShape(Capsule())
                }
                .disabled(name.isEmpty || description.isEmpty)
                .padding(.bottom, 10)
            }
            .padding(10)
        }
        .fullScreenCover(isPresented: $showMenuView) {
            MenuView(tripName: name, tripStartDate: startDate, tripEndDate: endDate)
        }
    }

    //(Hudson P 2023)
    /// Creates a new itinerary based on the user inputs and stores it in ``ItineraryModel``
 func createItinerary() {
     currentItinerary = ItineraryModel(tripName: name, tripStartDate: startDate, tripEndDate: endDate, tripDescription: description, items: [])
     modelContext.insert(currentItinerary)
   }
    
}


// Code for circular custom layout
// (RMIT Creds 2024)

/// 'RadialImageLayout' is a customised layout that provides a method to rearrange the subviews in a circular pattern
struct RadialImageLayout: Layout {
    /// This method is responsible for the size layout of the subviews
    /// - Parameters:
    ///   - proposal: The desired size of the layout
    ///   - subviews: The collection of subviews that will be arranged
    ///   - cache: Store results that can improve the layouts performance
    /// - Returns: The `CGSize` repesenting the desired size
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        proposal.replacingUnspecifiedDimensions()
    }
    
    /// This method is responsible for the circular layout arrangement for the subviews
    /// - Parameters:
    ///   - bounds: Area which the subviews will be placed
    ///   - proposal: Size information for placing subviews
    ///   - subviews: The collection of subviews that will be arranged
    ///   - cache: Store results that can improve the layouts performance
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        // Calculate the radius for the circular arrangement
        let radius = min(bounds.width, bounds.height) / 2.9// Adjust radius as needed
        
        // Calculate the angle between each item
        let angleIncrement = Angle.degrees(360.0 / Double(subviews.count)).radians
        
        for (index, subview) in subviews.enumerated() {
            // Calculate the position for each item in a circle
            let angle = angleIncrement * Double(index)
            let xOffset = radius * cos(angle)
            let yOffset = radius * sin(angle)
            
            let position = CGPoint(x: bounds.midX + xOffset, y: bounds.midY + yOffset)
            
            subview.place(at: position, anchor: .center, proposal: .unspecified)
        }
    }
}




/// A Preview for ``ItineraryView``
struct ItineraryView_Previews: PreviewProvider {
    static var previews: some View {
        ItineraryView()
    }
}




