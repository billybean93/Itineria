//
//  Place.swift
//  a2-S3909873-S3915181
//
//  Created by Bill Nguyen on 5/10/2024.
//

import Foundation

/// A response structure that contains a list of places fetched from an API.
///
/// `PlaceResponse` represents the top-level response structure for a query that returns nearby places.
/// The `results` array holds a list of `Place` objects, each representing a place with its name, address, and location details.
///
/// ## Properties
/// - `results`: An array of `Place` objects containing the information for each fetched
struct PlaceResponse: Codable {
    let results: [Place]
}

/// A structure that represents a place, including its name, address, and geographic location.
///
/// `Place` contains details about an individual place, including its unique identifier, name, formatted address, and geometry (location and viewport).
/// This structure conforms to `Identifiable` for use in SwiftUI lists.
///
/// ## Properties
/// - `id`: A unique identifier for the place, mapped from the `place_id` field.
/// - `name`: The name of the place.
/// - `formattedAddress`: The formatted address of the place, mapped from the `formatted_address` field.
/// - `geometry`: A `PlaceGeometry` object that holds the location and viewport details of the place.
///
/// ## Coding Keys
/// The `CodingKeys` enum maps the JSON field `place_id` to `id` and `formatted_address` to `formattedAddress`.
///
/// ## Example Usage
/// ```swift
/// let place = Place(id: "12345", name: "Central Park", formattedAddress: "New York, NY", geometry: PlaceGeometry(location: Location(lat: 40.785091, lng: -73.968285), viewport: Viewport(northeast: Location(lat: 40.800, lng: -73.940), southwest: Location(lat: 40.770, lng: -73.980))))
/// ```
///
struct Place: Codable, Identifiable {
    let id: String
    let name: String
    let formattedAddress: String
    let geometry: PlaceGeometry

    
    enum CodingKeys: String, CodingKey {
        case id = "place_id"
        case name
        case formattedAddress = "formatted_address"
        case geometry
    }
}
/// A structure representing the geometric details of a place, including its location and viewport.
///
/// `PlaceGeometry` contains the `location` (latitude and longitude) of a place and its `viewport`, which defines the visible area around the place on a map.
///
/// ## Properties
/// - `location`: A `Location` object representing the latitude and longitude of the place.
/// - `viewport`: A `Viewport` object representing the northeast and southwest boundaries of the place’s visible area.
///
/// ## Example Usage
/// ```swift
/// let geometry = PlaceGeometry(location: Location(lat: 40.785091, lng: -73.968285), viewport: Viewport(northeast: Location(lat: 40.800, lng: -73.940), southwest: Location(lat: 40.770, lng: -73.980)))
/// ```
struct PlaceGeometry: Codable {
    let location: Location
    let viewport: Viewport
}

/// A structure representing a geographic coordinate (latitude and longitude).
///
/// `Location` holds the latitude (`lat`) and longitude (`lng`) of a specific point, often used for pinpointing a place on a map.
///
/// ## Properties
/// - `lat`: The latitude of the location.
/// - `lng`: The longitude of the location.
///
/// ## Example Usage
/// ```swift
/// let location = Location(lat: 40.785091, lng: -73.968285)
///
struct Location: Codable {
    let lat: Double
    let lng: Double
}

/// A structure representing the boundaries (northeast and southwest) of a place's viewport on a map.
///
/// `Viewport` defines the visible area for a place, with two coordinates marking the northeast and southwest corners.
/// This is typically used for zooming in and displaying a place on a map within its bounding region.
///
/// ## Properties
/// - `northeast`: A `Location` object representing the northeast corner of the viewport.
/// - `southwest`: A `Location` object representing the southwest corner of the viewport.
///
/// ## Example Usage
/// ```swift
/// let viewport = Viewport(northeast: Location(lat: 40.800, lng: -73.940), southwest: Location(lat: 40.770, lng: -73.980))
/// ```
struct Viewport: Codable {
    let northeast: Location
    let southwest: Location
}
