//
//  CarouselView.swift
//  UIKi
//
//  Created by Bill Nguyen on 12/10/2024.
//

import SwiftUI
import UIKit
/// A SwiftUI view that embeds a UIKit-based carousel to display a collection of nearby places.
///
/// `CarouselView` is a `UIViewControllerRepresentable` component that wraps a UIKit view controller (`CarouselViewController`)
/// to display nearby places in a carousel format. This allows SwiftUI to interact with and manage a UIKit-based UI component.
///
/// - The `CarouselView` integrates a `CarouselViewController`, which handles the actual carousel logic.
/// - The `nearbyplaces` array is passed from SwiftUI to the UIKit controller for displaying each place in the carousel.
/// - The view uses the `makeUIViewController(context:)` and `updateUIViewController(_:context:)` methods to manage the lifecycle of the UIKit controller in a SwiftUI environment.
///
/// ## Topics
/// ### Properties
/// - `var nearbyplaces`: An array of `NearbyPlace` objects to be displayed in the carousel.
///
/// ### Example Usage
/// ```swift
/// struct ContentView: View {
///     let places = [NearbyPlace(name: "Central Park", location: CLLocationCoordinate2D(latitude: 40.785091, longitude: -73.968285))]
///
///     var body: some View {
///         CarouselView(nearbyplaces: places)
///     }
/// }
/// ```
///
/// ## Lifecycle
/// - `makeUIViewController(context:)`: Creates and returns the `CarouselViewController` instance.
/// - `updateUIViewController(_:context:)`: Updates the carousel view whenever the data in `nearbyplaces` changes.
///
/// ## UIKit Integration
/// This component bridges SwiftUI and UIKit by using `UIViewControllerRepresentable`, allowing you to embed UIKit view controllers inside SwiftUI views.
struct CarouselView: UIViewControllerRepresentable {
    /// The list of nearby places to be displayed in the carousel.

    var nearbyplaces: [NearbyPlace]
    /// Creates and returns a new `CarouselViewController` instance.
       ///
       /// - Parameter context: The context object provided by SwiftUI.
       /// - Returns: A `CarouselViewController` instance with the nearby places data set.
    func makeUIViewController(context: Context) -> CarouselViewController {
        let carouselVC = CarouselViewController()
        carouselVC.nearbyplaces = nearbyplaces
        return carouselVC
    }
    /// Updates the existing `CarouselViewController` when the data in `nearbyplaces` changes.
        ///
        /// - Parameters:
        ///   - uiViewController: The `CarouselViewController` instance managed by SwiftUI.
        ///   - context: The context object provided by SwiftUI.
    func updateUIViewController(_ uiViewController: CarouselViewController, context: Context) {
        uiViewController.nearbyplaces = nearbyplaces
        uiViewController.carouselCollectionView.reloadData()
    }
}
