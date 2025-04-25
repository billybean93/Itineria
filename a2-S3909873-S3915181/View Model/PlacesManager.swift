//
//  PlacesManager.swift
//  a2-S3909873-S3915181
//
//  Created by Bill Nguyen on 6/10/2024.
//

import Foundation
import UIKit
/// A class responsible for managing and fetching places data using Google Places API.
///
/// The `PlacesManager` class provides functionality for searching places based on a query, fetching nearby places,
/// and retrieving place photos using the Google Places API. It is an `ObservableObject`, so it can be used
/// in SwiftUI to update the UI when the data changes.
///
/// - The `searchPlaces` function performs a text-based search for places around a specific location.
/// - The `fetchNearbyPlaces` function fetches nearby places based on a given latitude and longitude.
/// - The `getPlacePhoto` function fetches a photo of a place using its photo reference.
///
/// This class uses asynchronous network calls via `URLSession` to interact with the Google Places API, and publishes
/// the results to SwiftUI using the `@Published` property wrapper.
///
/// ## Topics
/// ### Properties
/// - `@Published var places`: An array of `Place` objects representing the fetched places from the API.
/// - `let apiKey`: The API key used to authenticate requests to the Google Places API.
///
/// ### Functions
/// - `createSearchURL(query:latitude:longitude:)`: Creates a URL for performing a text-based place search with Google Places API.
/// - `searchPlaces(query:latitude:longitude:)`: Initiates a search request for places using a text query.
/// - `fetchNearbyPlaces(latitude:longitude:completion:)`: Fetches a list of nearby places based on geographic coordinates.
/// - `getPlacePhoto(photoReference:completion:)`: Retrieves a photo for a place using a photo reference ID.
///
/// ## Example Usage
/// ```swift
/// let manager = PlacesManager()
/// manager.searchPlaces(query: "restaurant", latitude: 37.7749, longitude: -122.4194)
/// ```
class PlacesManager: ObservableObject {
    /// An array of `Place` objects, published for SwiftUI to reactively update the UI.
    @Published var places: [Place] = []
    /// The API key used for authenticating requests with the Google Places API.
    let apiKey = "AIzaSyChWnp_Q7x4S9e32n2kte9KlEpGl1kFOLs" // Replace with your actual API Key
    
    /// Creates a URL for performing a text-based search for places.
        ///
        /// This method constructs a Google Places Text Search API URL using the provided search query, latitude, and longitude.
        ///
        /// - Parameters:
        ///   - query: The search query (e.g., "restaurants", "parks").
        ///   - latitude: The latitude coordinate for the search area.
        ///   - longitude: The longitude coordinate for the search area.
        /// - Returns: A properly encoded URL for performing the API request, or `nil` if the URL is invalid.
    func createSearchURL(query: String, latitude: Double, longitude: Double) -> URL? {
          let urlString = "https://maps.googleapis.com/maps/api/place/textsearch/json?query=\(query)&location=\(latitude),\(longitude)&key=\(apiKey)"
          return URL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
      }
    
    /// Searches for places using the Google Places Text Search API.
        ///
        /// This method fetches places using a text-based search query and geographic coordinates. The fetched places
        /// are decoded from the API response and updated in the `places` property.
        ///
        /// - Parameters:
        ///   - query: The search term for the type of places (e.g., "restaurants", "hotels").
        ///   - latitude: The latitude coordinate for the search area.
        ///   - longitude: The longitude coordinate for the search area.
        ///
        /// ## Example
        /// ```swift
        /// placesManager.searchPlaces(query: "cafe", latitude: 40.7128, longitude: -74.0060)
        /// ```
    func searchPlaces(query: String, latitude: Double, longitude: Double) {
         guard let url = createSearchURL(query: query, latitude: latitude, longitude: longitude) else {
             print("Invalid URL")
             return
         }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                print("Error fetching data: \(error)")
                return
            }
            
            guard let data = data else {
                print("No data returned")
                return
            }
            if let jsonString = String(data: data, encoding: .utf8) {
                          print("Raw API Response: \(jsonString)")
                      }
            
            do {
                // Decode JSON response
                let decodedResponse = try JSONDecoder().decode(PlaceResponse.self, from: data)
                // Print decoded response for debugging
                print("Decoded API Response: \(decodedResponse)")
                
                                
                DispatchQueue.main.async {
                    self?.places = decodedResponse.results
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
        task.resume() // Start the network request
    }
    /// Fetches nearby places using the Google Places API Nearby Search.
      ///
      /// This method retrieves a list of nearby places based on the provided latitude and longitude, then passes
      /// the results to the completion handler. It uses the nearby search endpoint and maps the result into
      /// `NearbyPlace` objects.
      ///
      /// - Parameters:
      ///   - latitude: The latitude of the location around which to search.
      ///   - longitude: The longitude of the location around which to search.
      ///   - completion: A closure that provides an array of `NearbyPlace` objects when the request completes.
      ///
      /// ## Example
      /// ```swift
      /// placesManager.fetchNearbyPlaces(latitude: 37.7749, longitude: -122.4194) { places in
      ///     print("Nearby places: \(places)")
      /// }
      /// ```
    func fetchNearbyPlaces(latitude: Double, longitude: Double, completion: @escaping ([NearbyPlace]) -> Void) {
        let urlString = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(latitude),\(longitude)&radius=100&key=\(apiKey)"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                print("Error fetching places: \(String(describing: error))")
                return
            }
            
            do {
                let result = try JSONDecoder().decode(NearbyPlacesResponse.self, from: data)
                let nearbyplaces = result.results.map {
                    NearbyPlace(id: $0.place_id, name: $0.name, photoReference: $0.photos?.first?.photo_reference)
                }
                completion(nearbyplaces)
            } catch {
                print("Failed to decode: \(error)")
            }
        }.resume()
    }
    /// Fetches a photo for a place using a photo reference ID.
    ///
    /// This method retrieves an image associated with a place by making a request to the Google Places API's
    /// photo endpoint. The resulting image is passed to the completion handler.
    ///
    /// - Parameters:
    ///   - photoReference: The reference ID for the photo associated with the place.
    ///   - completion: A closure that provides the `UIImage` when the photo is retrieved or `nil` if there was an error.
    ///
    /// ## Example
    /// ```swift
    /// placesManager.getPlacePhoto(photoReference: "CmRaAAAA...") { image in
    ///     if let image = image {
    ///         print("Successfully fetched place photo!")
    ///     }
    /// }
    /// ```
    func getPlacePhoto(photoReference: String, completion: @escaping (UIImage?) -> Void) {
        let urlString = "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=\(photoReference)&key=\(apiKey)"
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data, let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }.resume()
    }

    
}
