//
//  MenuView.swift
//  a2-S3909873-S3915181
//
//  Created by Daniel La on 27/9/2024.
//

import SwiftUI

//(Raja Yogan 2024)
/// 'MenuView' is a menu interface that navigates to different sections of the app
struct MenuView: View {
    /// A state variable that controls whether the ``MenuView`` is presented or not
    @State var menuShown = false
    /// A state variable used to present the home view
    @State private var home = false
    /// A parameter that represents the trip name
    var tripName: String
    /// A parameter that represents the trip starting date
    var tripStartDate: Date
    /// A parameter that represents the trip ending date
    var tripEndDate: Date
    /// A state object that manages the user details. Enables ``MenuView`` to access and display the stored information
    @StateObject private var profileDetails = ProfileDetails()
    /// A state variable which is displays ``PlannerView`` as default when first navigated
    @State var viewIndex = "Planner"
    /// This variable presents the title of the views that can be navigated from the menu
    var menuViews = ["Planner", "Share"]
    /// This variable associates the specific view from the menu with an icon
    var menuIcons = ["Planner": "mappin.and.ellipse.circle", "Share": "square.and.arrow.up"]
    var body: some View {
        
        //(Raja Yogan 2024)
        //A Hamburger Menu that allows navigation between views
        ZStack{
            (menuShown ? Color(red: 0.8, green: 1.0, blue: 0.8) : Color.clear).edgesIgnoringSafeArea(.all)
            
            ZStack(alignment: .leading){
                VStack(alignment: .leading, spacing: 25){
                    VStack(alignment: .center){
                        ImageStyle(imageName: "profileimage")
                        Text(profileDetails.profileName)
                            .bold()
                            .font(.system(size: 20))
                        Text("@" + profileDetails.userName)
                            .font(.system(size: 15))
                    }
                    .padding(.top, 80)
                    .padding(.bottom, 12)
                    
                    ForEach(menuViews, id: \.self){ item in
                        Button(action: {
                            viewIndex = item
                            withAnimation(.spring()){
                                menuShown.toggle()
                            }
                        }){
                            HStack{
                                if let iconName = menuIcons[item] {
                                    Image(systemName: iconName)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 22, height: 22)
                                        .foregroundStyle(item == "Share" ? Color.black : (item == "Settings" ? Color.gray : Color.red))

                                }
                                Text(item)
                            }
                        }
                    }
                    Spacer()
                    Button(action: {
                        home = true
                    })
                    {
                        HStack{
                            Image(systemName: "arrowshape.turn.up.backward.circle")
                                .resizable()
                                .renderingMode(/*@START_MENU_TOKEN@*/.template/*@END_MENU_TOKEN@*/)
                                .frame(width: 25, height: 25)
                            Text("Home")
                        }
                        .padding(.bottom)
                        
                    }
                    
                }
                .padding(.leading, 20)
                .padding(.top)
                .scaleEffect(menuShown ? 1:0)
                
                
                PlanningView(menuShown: $menuShown, viewIndex: $viewIndex, tripName: tripName, tripStartDate: tripStartDate, tripEndDate: tripEndDate)
                    .scaleEffect(menuShown ? 0.7:1)
                    .offset(x:  menuShown ? 160:0)
                    .disabled(menuShown ? true:false)
                    .shadow(radius: menuShown ? 3:0)
            }
        }
        .fullScreenCover(isPresented: $home) {
            ContentView()
        }
    }
}



