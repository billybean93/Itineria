//
//  CarouselNewView.swift
//  //
//  Created by Bill Nguyen on 12/10/2024.
//

import SwiftUI

import SwiftUI
/// A SwiftUI view that displays a carousel of nearby places based on the user's location.
///
/// `CarouselNewView` is designed to display a carousel of places fetched from an API based on the given latitude and longitude.
/// The view uses the `CarouselView` to render the nearby places and fetches the places using `PlacesManager` when the view appears.
/// This view serves as a SwiftUI view wrapper for CarouselView() which is made with UIKit.
///
/// ## Overview
/// - On appearing, the view fetches a list of nearby places using the given `latitude` and `longitude` coordinates.
/// - The fetched places are displayed using the `CarouselView` component, which handles the rendering of each place in a carousel format.
///
/// This view is useful in applications that need to show users nearby points of interest, such as restaurants, parks, or attractions.
///
/// ## Topics
/// ### Properties
/// - `@State var nearbyplaces`: A state variable that holds the list of places fetched from the API.
/// - `var latitude`: The latitude coordinate used for fetching nearby places.
/// - `var longitude`: The longitude coordinate used for fetching nearby places.
///
/// ### Example Usage
/// ```swift
/// struct ContentView: View {
///     var body: some View {
///         CarouselNewView(latitude: 37.7749, longitude: -122.4194) // San Francisco
///     }
/// }
/// ```
///
/// ## Fetching Data
/// - The `onAppear` modifier is used to trigger the data fetching operation from `PlacesManager`.
/// - The fetched places are asynchronously updated in the `nearbyplaces` state, which is then passed to the `CarouselView` for rendering.
///
/// ## View Structure
/// - A `NavigationView` wraps the main content, allowing for navigation to detailed views.
/// - Inside the `VStack`, the `CarouselView` displays the fetched nearby places as a carousel.
/// - The view's title is set to "Nearby Places" using the `navigationTitle` modifier.
///
/// ## SwiftUI Preview
/// This view includes a preview with sample coordinates for testing.
///

// MARK: - SwiftUI View to Display Carousel and Fetch Places
struct CarouselNewView: View {
    /// A state variable that stores the list of nearby places to display in the carousel.
    @State private var nearbyplaces = [NearbyPlace]() // State to hold nearby places
    /// The latitude coordinate used for fetching nearby places.
    var latitude: Double
    /// The longitude coordinate used for fetching nearby places.
    var longitude: Double

    var body: some View {
        NavigationView {
            VStack {
                // Display the carousel view with nearby places
                CarouselView(nearbyplaces: nearbyplaces)
                    .onAppear {
                        // Fetch nearby places when the view appears
                        PlacesManager().fetchNearbyPlaces(latitude: latitude, longitude: longitude) { fetchedPlaces in
                            DispatchQueue.main.async {
                                // Update the state with fetched places
                                self.nearbyplaces = fetchedPlaces
                            }
                        }
                    }
            }
            .navigationTitle("Nearby Places")
            .padding()
        }
    }
}
// MARK: - SwiftUI Preview
/// A preview of the `CarouselNewView` with example coordinates for testing.
///
/// This preview simulates the view with coordinates for a specific location (-37.8216
struct CarouselNewView_Previews: PreviewProvider {
    static var previews: some View {
        CarouselNewView(latitude: -37.8216, longitude: 145.0367)
    }
}
