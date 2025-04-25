//
//  ItinerarySettings.swift
//  a2-S3909873-S3915181
//
//  Created by Daniel La on 3/10/2024.
//

import Foundation
import SwiftUI
import PhotosUI

/// 'ItinerarySettings' is a view to modify details of selected itineraries
struct ItinerarySettings: View {
    /// A bindable property that holds the details of the selected itinerary being edited
    @Bindable var itineraryItem: ItineraryModel
    /// A optional state property that stores the selected photo from Photo Picker
    @State private var selectPhoto: PhotosPickerItem?  //(Hudson P 2023)

    var body: some View {
        VStack(alignment: .center){
            Text("Edit Itinerary")
                .font(.title)
            //Form to edit Itinerary
            Form{
                Section{
                    //(Hudson P 2023)
                    if let imageData = itineraryItem.photo,
                       let uiImage = UIImage(data: imageData){
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                            .frame(height: 150)
                            .clipped()
                            .cornerRadius(10)
                    }
                    PhotosPicker(selection: $selectPhoto, matching: .images){
                        Label("Select Cover Image", systemImage: "photo")
                    }
                }
                Section("Trip Name"){
                    TextField("Edit Trip Name", text: $itineraryItem.tripName)
                }
                
                Section("Description"){
                    TextEditor(text: $itineraryItem.tripDescription)
                        .frame(height: 170)
                }
                
                
                Section("Trip Dates") {
                    // Start Date
                    //(Asperi 2019)
                    CustomDateFormat.datePickerSection(label: "Start", date: Binding(
                        get: { itineraryItem.tripStartDate }, // Provide a default date
                        set: { itineraryItem.tripStartDate = $0! }
                    ))
                    
                    // End Date
                    //(Asperi 2019)
                    CustomDateFormat.datePickerSection(label: "End", date: Binding(
                        get: { itineraryItem.tripEndDate }, // Provide a default date
                        set: { itineraryItem.tripEndDate = $0! }
                    ), minimumDate: itineraryItem.tripStartDate) // Minimum date
                }            }
            .onChange(of: selectPhoto) { newItem in
                loadPhoto()
            }
        }
        .padding(20)
    }
    
    //(Hudson P 2023)
    /// Loads the selected photo `selectPhoto`
    func loadPhoto(){
        Task{ @MainActor in
            itineraryItem.photo = try await selectPhoto?.loadTransferable(type: Data.self)
        }
    }

}



