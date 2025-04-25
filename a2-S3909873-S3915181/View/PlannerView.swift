//
//  PlannerView.swift
//  a2-S3909873-S3915181
//
//  Created by Daniel La on 27/9/2024.
//

import SwiftUI
import SwiftData

/// 'PlannerView' is a view that displays a list of planner items associated with the specific itinerary
struct PlannerView: View{
    /// An environmental variable that gives access to the data model context
    @Environment(\.modelContext) var modelContext
    /// A parameter that represents the trip name
    var tripname: String
    /// A state variable that manages the navigation path of planner items
    @State private var path = [PlannerItems]()
    /// A query variable that fetches the Itinerary Model Data
    @Query var itineraries: [ItineraryModel]
    /// A computed property that retrieves the itinerary that matches ``tripname``
    var currentItinerary: ItineraryModel? {
          itineraries.first { $0.tripName == tripname } //(Hudson P 2023)
      }

      var body: some View {
          //(Hudson P 2023)
          //Navigation and presentation for planner items
          NavigationStack(path: $path) {
              List {
                  if let currentItinerary = currentItinerary, let items = currentItinerary.items {
                      ForEach(items) { loc in
                          NavigationLink(destination: EditPlannerView(editPlan: loc)) {
                              VStack(alignment: .leading) {
                                  if let imageData = loc.photo, let uiImage = UIImage(data: imageData) {
                                      Image(uiImage: uiImage)
                                          .resizable()
                                          .scaledToFill()
                                          .frame(height: 150)
                                          .clipped()
                                          .cornerRadius(10)
                                  }

                                  Text(loc.destination.isEmpty ? "Untitled" : loc.destination)
                                      .font(.headline)
                                      .padding(.top, 5)

                                  HStack {
                                      if let startDate = loc.startDate {
                                          Text("Start: \(CustomDateFormat.formatDate(startDate))")
                                              .font(.subheadline)
                                              .foregroundColor(.gray)
                                      }
                                      Spacer()
                                      if let endDate = loc.endDate {
                                          Text("End: \(CustomDateFormat.formatDate(endDate))")
                                              .font(.subheadline)
                                              .foregroundColor(.gray)
                                      }
                                  }
                                  .padding(.top, 2)
                              }
                              .padding(.vertical)
                              .frame(maxWidth: .infinity)
                          }
                      }
                      .onDelete(perform: deletePlanner)
                  }
              }
              .navigationDestination(for: PlannerItems.self) { loc in
                  EditPlannerView(editPlan: loc)
              }
              .toolbar {
                  Button("Add New Destination", systemImage: "plus", action: addPlanner)
              }
          }
      }
    
    //(Hudson P 2023 & Tundsdev 2023)
    /// Adds a new planner item to the itinerary and updates the navigation path
      func addPlanner() {
          let newPlannerItem = PlannerItems(destination: "", startDate: nil, endDate: nil, notes: "")
          currentItinerary?.items?.append(newPlannerItem)
          modelContext.insert(newPlannerItem)
          path.append(newPlannerItem)
      }
    
    //(Hudson P 2023 & Tundsdev 2023)
    /// Deletes the selected planner item from the current itinerary
    /// - Parameter offsets: The indices of the planner item selected to be deleted from the current itinerary
      func deletePlanner(at offsets: IndexSet) {
          if let currentItinerary = currentItinerary, let items = currentItinerary.items {
              for offset in offsets {
                  let loc = items[offset]
                  modelContext.delete(loc)

              }
          }
      }
  }
