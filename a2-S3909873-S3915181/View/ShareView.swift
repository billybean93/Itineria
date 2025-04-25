//
//  ShareView.swift
//  a2-S3909873-S3915181
//
//  Created by Daniel La on 7/10/2024.
//

import Foundation
import SwiftUI

/// 'ShareView' is a view to share travel itineraries through generated links
struct ShareView: View {
    /// A parameter that represents the trip name
    var tripName: String
    /// A state object that manages the user details. Enables ``ShareView`` to access and display the stored information
    @StateObject private var profileDetails = ProfileDetails()
    var body: some View {
        
        //Creates a link to share itinerary
        //(Hudson P 2023)
        ShareLink(item: URL(string: "https://www.itineria/plan/" + profileDetails.profileName + "/" + tripName + ".com")!, subject: Text(tripName), message: Text("Check out " + profileDetails.profileName + " " + tripName + " Itinerary")){
            Label("Share your journey with the world!", systemImage: "square.and.arrow.up")
        }
    }
}

/// A preview for ``ShareView``
struct ShareView_Preview: PreviewProvider {
    static var previews: some View {
        ShareView(tripName: "")
    }
}
