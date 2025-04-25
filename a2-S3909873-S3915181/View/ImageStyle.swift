////
//  ImageStyle.swift
//  a1-S3909873-S3915181
//
//  Created by Daniel La on 29/8/2024.
//
import SwiftUI

/// 'ImageStyle' is a customised view for the ``ItineraryView`` & ``RadialImageLayout``, where it reduces code redundancy for displaying the images
struct ImageStyle: View {
    /// A string property that specifies the name of the image to be displayed.
    ///
    /// String must match the image asset name
    /// ```swift
    ///        Image(imageName)
    ///  ```
    let imageName: String
    var body: some View {
        //Code to reduce redundancy for itinerary page image style
        Image(imageName)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 65, height: 65)
            .clipShape(Circle())
            .overlay(
                Circle().stroke(Color.white, lineWidth: 3)
            )
            .shadow(radius: 10)
    }
}
