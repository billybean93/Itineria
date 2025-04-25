//
//  PlannerItems.swift
//  a2-S3909873-S3915181
//
//  Created by Daniel La on 30/9/2024.
//

import Foundation
import SwiftData

//(Indently 2021)
/// 'PlannerItems' represent the individual planner items that can be created within the itinerary, such as the destination, dates, notes and optional photos. This model serves as the `Child` of  ``ItineraryModel``
@Model
class PlannerItems {
    /// A variable that stores the destination of the planner item
    var destination: String
    /// A variable that stores the starting date of the planner item
    var startDate: Date?
    /// A variable that stores the ending date of the planner item
    var endDate: Date?
    /// A variable that stores the notes of the planner item
    var notes: String
    /// An optional variable that saves the photo associated with the planner item, storing the information as raw data
    @Attribute(.externalStorage) var photo: Data? //(Hudson P 2023)
    /// A defined `Child` relationship to ``ItineraryModel``, indicating which itinerary this planner item belongs to
    var tripID: ItineraryModel? //(Hudson P 2023)
    
    /// Initialises a new instance of ``PlannerItems``
    /// - Parameters:
    ///   - destination: The destination of the planner item
    ///   - startDate: The starting date of the planner item. This defaults `nil` if date is not provided
    ///   - endDate: The ending date of the planner item. This defaults `nil`  if date is not provided
    ///   - notes: The notes of the planner item
    ///   - tripID:The associated itinerary that this planner item belongs to. This defaults to `nil` if not provided.
    init(destination: String, startDate: Date? = nil, endDate: Date? = nil, notes: String, tripID: ItineraryModel? = nil) {
        self.destination = destination
        self.startDate = startDate
        self.endDate = endDate
        self.notes = notes
        self.tripID = tripID
    }
}
