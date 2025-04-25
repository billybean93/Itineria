//
//  CustomDateFormat.swift
//  a2-S3909873-S3915181
//
//  Created by Daniel La on 7/10/2024.
//

import Foundation
import SwiftUI

/// 'CustomDateFormat' is a struct that contains methods to either format the dates into specific styles or apply constraints on `DatePicker` elements
struct CustomDateFormat {
    
    //(Prater K 2023 & Hudson P 2022)
    /// This function formats the chosen dates into `.medium` style string (e.g. 1 Jan 2024)
    /// - Parameter date: The provided `Date` object to be formatted into the specific style
    /// - Returns: A `String` with the formatted date
    ///
    /// Returns the formatted date into a `String` object
    ///```swift
    ///return dateFormatter.string(from: date)
    ///```
     static func formatDate(_ date: Date) -> String {
        let dateFormatter = Foundation.DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: date)
    }
    
    //(SchmidtFx 2020 & Asperi 2019 & Hudson P 2023)
    /// Creates a `DatePicker` and applies constraints based on the dates provided
    /// - Parameters:
    ///   - label: A label that can be displayed with the `DatePicker`
    ///   - date: A binding to the `Date` that will be displayed and updated
    ///   - minimumDate: The optional earliest/minimum date that can be selected based on the provided `Date` objects. This defaults to distant past if `nil`
    /// - Returns: Returns a `SwiftUI DatePicker` that can be interacted with
    ///
    /// This code returns a interactive `DatePicker` that allows users to select date within the specified range based on the `Date` object provided
    /// ```swift
    /// return DatePicker(label, selection: Binding(
    /// get: { date.wrappedValue ?? Date() },
    /// set: { date.wrappedValue = $0 }
    /// ), in: startDate...endDate, displayedComponents:
    /// .date)
    /// ```
    static func datePickerSection(label: String, date: Binding<Date?>, minimumDate: Date? = nil) -> some View {
        let startDate: Date = minimumDate ?? Date.distantPast
         let endDate: Date = Date.distantFuture
         
         return DatePicker(label, selection: Binding(
             get: { date.wrappedValue ?? Date() }, // If `date` is nil, use today's date
             set: { date.wrappedValue = $0 }       // When user selects a new date, update the binding
         ), in: startDate...endDate, displayedComponents: .date)
    }
}
