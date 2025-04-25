//
//  ItineraryModel.swift
//  a2-S3909873-S3915181
//
//  Created by Daniel La on 2/10/2024.
//

import Foundation
import SwiftData

/// 'ItineraryModel' represents the itinerary model for the trip. This is a database utilising SwiftData to store trip details such as trip name, dates, descriptions, photos and ``PlannerItems`` associated with the itinerary. This model serves as the `Parent`of  ``PlannerItems``
@Model
class ItineraryModel: Identifiable, ObservableObject {
    /// A variable that is the unique identifier for each itinerary
    var id: UUID
    /// A variable that stores the name of the trip
    var tripName: String
    /// A variable that stores the starting date of the trip
    var tripStartDate: Date
    /// A variable that stores the ending date of the trip
    var tripEndDate: Date
    /// A variable that stores the description of the trip
    var tripDescription: String
    /// An optional variable that saves the photo associated with the trip, storing the information as raw data
    @Attribute(.externalStorage) var photo: Data? //(Hudson P 2023)
    /// A defined Parent relationship to ``PlannerItems``, with a cascade delete rule that removes all associated items if the trip is deleted
    @Relationship(deleteRule: .cascade, inverse: \PlannerItems.tripID) var items: [PlannerItems]? //(Hudson P 2023)
    
    /// Initialises a new instance of ``ItineraryModel``
    /// - Parameters:
    ///   - tripName: The name of the trip
    ///   - tripStartDate: The starting date of the trip. This defaults to the current date if it is `nil`
    ///   - tripEndDate: The ending date of the trip. This defaults to the current date if it is `nil` 
    ///   - tripDescription: A description of the trip
    ///   - items: An array of ``PlannerItems`` that is associated with the trip
    init(tripName: String, tripStartDate: Date? = nil, tripEndDate: Date? = nil, tripDescription: String, items: [PlannerItems]) {
        self.id = UUID()
        self.tripName = tripName
        self.tripStartDate = tripStartDate ?? Date()
        self.tripEndDate = tripEndDate ?? Date()
        self.tripDescription = tripDescription
        self.items = items
    }
    

}
