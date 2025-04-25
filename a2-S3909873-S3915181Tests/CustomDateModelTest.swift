//
//  CustomDateModelTest.swift
//  a2-S3909873-S3915181Tests
//
//  Created by Daniel La on 11/10/2024.
//

import XCTest
@testable import a2_S3909873_S3915181
final class CustomDateModelTest: XCTestCase {
    
    // Test to ensure that the date formatter function is correctly formatting chosen dates. It is crucial as the formatted dates are essential in data representation for the user interface.
    func testDateFormat () {
        // Created Date Components of 1 Jan 2024. Then converted the components to Date object. If if it fails use current date
        // (Hudson P 2023)
        let dateComponents = DateComponents(year: 2024, month: 1, day: 1)
        let date = Calendar.current.date(from: dateComponents) ?? .now
            
        // Format the date using CustomDateFormat
        let formattedDate = CustomDateFormat.formatDate(date)
        
        // Define the expected date format
        let expectedDate = "1 Jan 2024"
            
        // Verify that the formatted date is equal to the expected date
        XCTAssertEqual(formattedDate, expectedDate, "The date format should be \(expectedDate)")
        
    }


}
