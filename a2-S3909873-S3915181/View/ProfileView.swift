////
//  ProfileView.swift
//  a1-S3909873-S3915181
//
//  Created by Daniel La on 19/8/2024.
//

import SwiftUI
import SwiftData
/// 'ProfileView' is a view that serves as the core interface for displaying user information, created itineraries and additional settings. Users can modify their profile, view settings and manage their trips
struct ProfileView: View {
    /// A state object that manages the user details. Enables ``ProfileView`` to access and display the stored information
    @StateObject private var profileDetails = ProfileDetails()
    /// A state variable to track the rotation animation
    @State var rotate = false
    /// A state variable to track the selected tab
    @State private var selectedTab: String = ""
    /// A state variable that controls whether the ``MenuView`` is presented or not
    @State private var showMenuView = false
    /// A query variable that fetches the Itinerary Model Data
    @Query var itineraries: [ItineraryModel]
    /// An environmental variable that gives access to the data model context
    @Environment(\.modelContext) var modelContext
    /// A state variable that controls whether ``ItineraryView`` is presented or not
    @State private var showingSettings = false
    var body: some View{
        // Background image
        NavigationView{
            VStack{
                Image("river")
                    .resizable()
                    .ignoresSafeArea()
                    .frame(width: 400)
                    .frame(height: 150)
                    .scaledToFill()
                
                ZStack{
                    HStack{
                        // Settings nav link
                        NavigationLink(destination:SettingsView()){
                            Image(systemName: "gear")
                                .font(.system(size: 30))
                                .padding(0)
                        }
                        .accentColor(.black)
                        Spacer()
                        ZStack{
                            // Profile image with double circles
                            Circle()
                                .fill(Color.white)
                                .frame(width: 170, height: 170)
                                .offset(y: -140)
                                .padding(.bottom, -130)
                                .shadow(color: Color.green, radius: 5, x: 0, y: 0)
                            Circle()
                                .fill(Color.red)
                                .frame(width: 150,
                                       height: 150)
                                .offset(y: -140)
                                .padding(.bottom, -130)
                                .shadow(color: Color.red, radius: 3, x: 0, y: 0)
                        }
                        
                        Spacer()
                        // Edit profile nav link
                        NavigationLink(destination: EditProfilePage()){
                            Image(systemName:"square.and.pencil")
                                .font(.system(size: 30))
                                .padding(0)
                        }
                        .accentColor(.black)
                    }
                    // Initials within profile image
                    Text(profileDetails.nameInitials)
                        .foregroundColor(.white)
                        .font(.system(size: 75,
                                      weight: .bold))
                        .offset(y: -120)
                        .padding(.bottom, -130)
                }
                
                
                // Name and Username
                VStack(spacing: 10){
                    VStack{
                        Text(profileDetails.profileName)
                            .bold()
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        Text("@" + profileDetails.userName)
                            .shadow(radius: 10)
                            .font(.subheadline)
                    }
                }
                
                // Tab selection
                HStack{
                    Button(action: {
                        if selectedTab == "Trips" {
                            selectedTab = ""
                        } else {
                            selectedTab = "Trips"
                        }
                    }) {
                        HStack {
                            Image(systemName: "suitcase")
                                .foregroundStyle(Color(hue: 1.0, saturation: 0.514, brightness: 0.66))
                                .font(.system(size: 20))
                            Text("Trips")
                                .font(.system(size: 15))
                                .foregroundColor(selectedTab == "Trips" ? Color.blue : Color.black)
                        }
                        .padding(10)
                        .padding(.horizontal, 80)
                        .background(selectedTab == "Trips" ? Color.gray.opacity(0.2) : Color.clear) // Highlight background
                        .cornerRadius(10)
                    }
                    .gesture(
                        TapGesture(count: 2)
                            .onEnded {
                                if selectedTab == "Trips" {
                                    selectedTab = ""
                                }
                            }
                    )
                    
                }
                .frame(width: 250)
                .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray, lineWidth: 2)
                    .opacity(0.2))
                
                
                
                //(Hudson P 2023 & Tundsdev 2023 & Swiftful Thinking 2021)
                // Displays list of created itinerary
                if selectedTab == "Trips" {
                    List {
                        ForEach(itineraries) { item in
                            NavigationLink(destination: MenuView(tripName: item.tripName, tripStartDate: item.tripStartDate, tripEndDate: item.tripEndDate)
                                .navigationBarBackButtonHidden(true)
                            ) {
                                CustomListItemView(item: item)
                                    .padding()
                            }
                            .swipeActions(edge: .leading, allowsFullSwipe: true) {
                                Button{
                                    showingSettings = true
                                }
                            label: {
                                Label("Edit", systemImage: "pencil.circle")
                            }
                            .tint(Color.blue)
                            }
                            .sheet(isPresented: $showingSettings) {
                                ItinerarySettings(itineraryItem: item)
                            }
                        }
                        .onDelete(perform: deleteItinerary)
                        
                    }
    
                }
                else {
                    // Airplane layout
                    // Custom Layout for airplane rotating
                    // (RMIT Creds 2024) & (Core SwiftUI: Animation & Design 2022)
                       ZStack {
                           airplaneLayout {
                               Image(systemName: "airplane")
                                   .foregroundColor(.black)
                                   .rotationEffect(Angle(degrees: 90))
                           }
                           .onAppear {
                               withAnimation(Animation.linear(duration: 10).repeatForever(autoreverses: false)) {
                                   rotate.toggle()
                               }
                           }
                           .rotationEffect(Angle(degrees: rotate ? 360 : 0))
                           
                           Image("globe")
                               .resizable()
                               .frame(height: 340)
                               .frame(maxWidth: .infinity)
                           
                           HStack(spacing: 20) {
                               Text("Press")
                                   .bold()
                               Image(systemName: "plus.circle")
                                   .padding(5)
                                   .background(Color.white)
                                   .clipShape(Circle())
                                   .foregroundStyle(Color.green)
                                   .font(.system(size: 25))
                                   .shadow(color: Color.green, radius: 10, x: 0, y: 0)
                               Text("to create your trip")
                                   .bold()
                           }
                       }
                   }
                   Spacer()
               }
               .padding(.horizontal, 30)
           }
       }
    
    //(Hudson P 2023 & Tundsdev 2023)
    /// Deletes the selected itinerary
    /// - Parameter offsets: The indices of the itinerary selected to be deleted
    func deleteItinerary(at offsets: IndexSet) {
        for offset in offsets {
            let itineraryItem = itineraries[offset]
            modelContext.delete(itineraryItem) // Deletes the item from the context
        }
    }

    }
    

/// 'CustomListItemView' is a view within ``ProfileView`` that presents the list of itinerary items within the ``ItineraryModel``
struct CustomListItemView: View {
    /// A variable that holds the items within the ``ItineraryModel``
        var item: ItineraryModel
        var body: some View {
            VStack(alignment: .center, spacing: 10) {
                if let imageData = item.photo, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 100)
                        .clipped()
                        .cornerRadius(10)
                }
                HStack{
                    Text(item.tripName)
                        .font(.headline)
                        .padding(.vertical, 5)
                    Spacer()
                    VStack{
                        Text("Start: \(CustomDateFormat.formatDate(item.tripStartDate))")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Text("End: \(CustomDateFormat.formatDate(item.tripEndDate))")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    .padding(.vertical, 5)
                }
            }
            .padding(15) // Reduced padding around the whole item
            .background(Color(.systemBackground))
            .cornerRadius(10)
            .shadow(color: .gray.opacity(0.5), radius: 3, x: 0, y: 2) // Lighter shadow for a smaller effect
            .frame(maxWidth: .infinity)

        }
    }

        
    
    
// Code for custom airplane layout
// (RMIT Creds 2024)
/// 'airplaneLayout' is a customised layout that arranges the views in a circular pattern
struct airplaneLayout: Layout {
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
            let radius = min(bounds.width, bounds.height) / 2.5  // Adjust radius as needed
            
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









