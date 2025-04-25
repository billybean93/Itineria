//
//  PlacesManagerModelTest.swift
//  a2-S3909873-S3915181Tests
//
//  Created by Daniel La on 11/10/2024.
//

import XCTest
@testable import a2_S3909873_S3915181
final class PlacesManagerModelTest: XCTestCase {
    
    // Test Create Search URL function to verify that the URL is being created. It is important to ensure that the information passed into the method does not return a nil value and that the parameters are being processed and generated into a URL correctly
    func testCreateSearchURL() {
        // Create an instance of PlacesManager
        let viewModel = PlacesManager()
        // Define the sample parameters
        let query = "restaurants"
        let latitude = 37.7749
        let longitude = -122.4194

        // Call the create URL function with the defined parameters
        let url = viewModel.createSearchURL(query: query, latitude: latitude, longitude: longitude)
        
        // Verify that the URL is not nil
        XCTAssertNotNil(url)
       }
    
    // Test to verify that the generated URL matches the expected URL format. It is to make sure that the generated URL is correctly formatted to communicate with external services to retreieve data
    func testVerifyURL () {
        // Create an instance of PlacesManager
        let viewModel = PlacesManager()
        // Define the sample parameters
        let query = "restaurants"
        let latitude = 37.7749
        let longitude = -122.4194
        
        // Call the create URL function with the defined parameters
        let url = viewModel.createSearchURL(query: query, latitude: latitude, longitude: longitude)
        // Constructed expected string based on the defined parameters & converted string to URL for comparison
        let expectedURLString = "https://maps.googleapis.com/maps/api/place/textsearch/json?query=\(query)&location=\(latitude),\(longitude)&key=\(viewModel.apiKey)"
        let expectedURL = URL(string: expectedURLString)
        
        // Verify that the generated URL matches the expected URL
        XCTAssertEqual(url, expectedURL, "The URL matches the expected URL")

    }
    
    // Test to verify whether an invalid photo referenence will return nil. This tests the behaviour of the functionality if the provided photo reference was invalid, ensuring that the app does not crash unpredictably. Helps with identifying issues within the code logic
    func testInvalidPhotoReference() {
        // Create an instance of PlacesManager
        let viewModel = PlacesManager()
        // Define the invalid sample parameter
        let invalidPhotoReference = "invalid url"
        // Create a variable = nil. This will be tested with the retrieved populated data
        var retrievedImage: UIImage? = nil
        
        // Call the getPlacePhoto function and passes in the invalid sample parameter. Then it returns and assigns the image to the created variable. The data within is nil
        viewModel.getPlacePhoto(photoReference: invalidPhotoReference) { image in
            retrievedImage = image
        }
        
        // Verify that the invalid sample parameter returns nil when being passed through the getPlacePhoto function
        XCTAssertNil(retrievedImage, "Image should be nil when photo reference is invalid")
    }
    

}
