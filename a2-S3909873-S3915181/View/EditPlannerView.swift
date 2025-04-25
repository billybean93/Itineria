//
//  EditPlannerView.swift
//  a2-S3909873-S3915181
//
//  Created by Daniel La on 30/9/2024.
//

import SwiftUI
import PhotosUI
/// 'EditPlannerView' is a view to modify details of planner items
struct EditPlannerView: View {
    /// A bindable property that holds the details of the selected planner item being edited
    @Bindable var editPlan: PlannerItems
    /// A optional state property that stores the selected photo from Photo Picker
    @State private var selectPhoto: PhotosPickerItem? //(Hudson P 2023)
    var body: some View {
        //Form to edit planner items
        Form {
            Section("Photo"){
                //(Hudson P 2023)
                if let imageData = editPlan.photo,
                   let uiImage = UIImage(data: imageData){
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 150)
                        .clipped()
                        .cornerRadius(10)
                }
                PhotosPicker(selection: $selectPhoto, matching: .images){
                    Label("Select a photo", systemImage: "photo")
                }
            }
            Section("Name") {
                TextField("Destination", text: $editPlan.destination)
            }
            
            Section("Dates") {
                // Start Date
                //(Asperi 2019)
                CustomDateFormat.datePickerSection(label: "Start Date", date: $editPlan.startDate)
                             
                // End Date
                //(Asperi 2019)
                CustomDateFormat.datePickerSection(label: "End Date", date: $editPlan.endDate, minimumDate: editPlan.startDate)
            }
            
            Section("Notes"){
                TextEditor(text: $editPlan.notes)
                    .frame(height: 170)
            }
            
        }
        .navigationTitle("Edit Planner")
        .navigationBarTitleDisplayMode(.inline)
        .onChange(of: selectPhoto) { newItem in
            loadPhoto()
        }
    }
    
    //(Hudson P 2023)
    /// Loads the selected photo `selectPhoto`
    func loadPhoto(){
        Task{ @MainActor in
            editPlan.photo = try await selectPhoto?.loadTransferable(type: Data.self)
        }
    }
    
}

