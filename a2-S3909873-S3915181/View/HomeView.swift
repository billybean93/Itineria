//
//  HomeView.swift
//  a2-S3909873-S3915181
//
//  Created by Daniel La on 8/10/2024.
//

import Foundation
import SwiftUI

/// 'HomeView' is a container that provides a tabbed navigation structure for users to access different areas of the app
struct HomeView:View {
    /// Keep track of selected tab index for TabView
    @State var selectedTab = 0
    var body: some View {
        HStack {
            // Tab view for all the views
            // (Indently 2021)
            TabView(selection: $selectedTab){
                ProfileView()
                    .tabItem(){
                        Image(systemName: "person")
                        Text("Me")
                    }
                    .tag(0)
                
                ItineraryView()
                    .tabItem(){
                        Image(systemName: "plus.circle")
                    }
                    .tag(1)
                
                MapView()
                    .tabItem(){
                        Image(systemName: "map")
                        Text("Map")
                    }
                    .tag(2)
            }
            .accentColor(Color(hue: 0.577, saturation: 1.0, brightness: 0.978))
        }

    }
}


/// A preview for ``HomeView``
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
