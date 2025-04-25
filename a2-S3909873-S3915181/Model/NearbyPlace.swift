//
//  NearbyPlace.swift
//  
//
//  Created by Bill Nguyen on 12/10/2024.
//

// A model representing a nearby place returned by the Google Places API.
///
/// `NearbyPlace` holds essential details about a place, including its unique identifier (`id`),
/// the name of the place, and an optional `photoReference` for retrieving associated images.
///
/// This model conforms to `Identifiable`, making it easy to use in SwiftUI views.
///
/// ## Properties
/// - `id`: A unique identifier for the place.
/// - `name`: The name of the place.
/// - `photoReference`: An optional string that can be used to fetch an image for the place, if available.
///
/// ## Example Usage
/// ```swift
/// let place = NearbyPlace(id: "ChIJN1t_tDeuEmsRUsoyG83frY4", name: "Sydney Opera House", photoReference: "CmRaAAAA...")
/// ```
// MARK: - Place Model
struct NearbyPlace: Identifiable {
    let id: String
    let name: String
    let photoReference: String?
}

/// A model representing the Google Places API response for nearby places.
///
/// `NearbyPlacesResponse` contains a list of `NearbyPlaceResult` objects, each representing a place returned
/// by the API. This response model is used to decode the JSON response from the Google Places API.
///
/// ## Properties
/// - `results`: An array of `NearbyPlaceResult` objects, representing each place returned by the API.
///
/// ## Example Usage
/// ```swift
/// let response = try JSONDecoder().decode(NearbyPlacesResponse.self, from: jsonData)
/// print(response.results)  // Array of NearbyPlaceResult objects
/// ```
struct NearbyPlacesResponse: Codable {
    let results: [NearbyPlaceResult]
}
/// A model representing an individual place result in the Google Places API response.
///
/// `NearbyPlaceResult` contains the essential data for a place, including its unique `place_id`,
/// its name, and an optional array of `Photo` objects that provide photo references for fetching images.
///
/// ## Properties
/// - `place_id`: A unique identifier for the place.
/// - `name`: The name of the place.
/// - `photos`: An optional array of `Photo` objects that can be used to retrieve images associated with the place.
///
/// ## Example Usage
/// ```swift
/// let placeResult = NearbyPlaceResult(place_id: "ChIJN1t_tDeuEmsRUsoyG83frY4", name: "Sydney Opera House", photos: [Photo(photo_reference: "CmRaAAAA...")])
/// ```
struct NearbyPlaceResult: Codable {
    let place_id: String
    let name: String
    let photos: [Photo]?
}
/// A model representing a photo reference for a place returned by the Google Places API.
///
/// `Photo` contains a reference string (`photo_reference`) that can be used to fetch the actual image associated with a place.
///
/// ## Properties
/// - `photo_reference`: A string that can be used to fetch the image associated with the place.
///
/// ## Example Usage
/// ```swift
/// let photo = Photo(photo_reference: "CmRaAAAA...")
/// ```
struct Photo: Codable {
    let photo_reference: String
}
