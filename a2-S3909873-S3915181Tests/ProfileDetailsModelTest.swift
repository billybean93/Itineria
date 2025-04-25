//
//  ProfileDetailsModelTest.swift
//  a2-S3909873-S3915181Tests
//
//  Created by Daniel La on 10/10/2024.
//

import XCTest
@testable import a2_S3909873_S3915181
final class ProfileDetailsModelTest: XCTestCase {
    
    // Test to verify a valid email. Verifies the email is formatted correctly (containing @ & ".com"), to ensure only valid emails are accepted. This helps prevent user errors
    func testValidEmail() {
        // Create an instance of ProfileDetails and define a sample valid email
        let viewModel = ProfileDetails()
        let email = "daniel@icloud.com"
        
        // Call the email validation function to verify the sample email
        let isValid = viewModel.validateEmail(email: email)
        
        // Check if it is True and that the email is valid
        XCTAssertTrue(isValid, "The Email is Valid")
    }
    
    // Test to verify for several variations of invalid emails (do not contain @ & ".com") to fail the validation. It is to ensure that the validation function does not accept these invalid emails and prevent incorrect data entry
    func testInvalidEmail() {
        // Create an instance of ProfileDetails and define sample invalid emails
        let viewModel = ProfileDetails()
        let email1 = "daniel@icloud.con"
        let email2 = "daniel@icloud"
        let email3 = "daniel"
        
        // Call the email validation function to verify the sample emails
        let isValidEmail1 = viewModel.validateEmail(email: email1)
        let isValidEmail2 = viewModel.validateEmail(email: email2)
        let isValidEmail3 = viewModel.validateEmail(email: email3)
        
        // Check if it is False and that the emails are invalid
        XCTAssertFalse(isValidEmail1, "The email \(email1) is invalid.")
        XCTAssertFalse(isValidEmail2, "The email \(email2) is invalid.")
        XCTAssertFalse(isValidEmail3, "The email \(email3) is invalid.")
    }
    
    // Test to ensure that the profile details are being saved correctly. It is to check that the stored properties matches the provided values and the function behaves as expected
    func testDetailsSaved() {
        // Create an instance of ProfileDetails and define the sample details
        let viewModel = ProfileDetails()
        let name = "Daniel La"
        let email = "daniel@icloud.com"
        let username = "Daniel4la"
        
        // Call the save profile function, providing sample details
        viewModel.saveProfile(name: name, email: email, userName: username)
        
        // Verifies that profile details were saved correctly, and the saved details matches the provided sample details
        XCTAssertEqual(viewModel.profileName, name, "Profile Name should be \(name)")
        XCTAssertEqual(viewModel.email, email, "Profile Email should be \(email)")
        XCTAssertEqual(viewModel.userName, username, "Profile Username should be \(username)")
    }
        
    // Test to ensure that the initials is being generated and formatted correctly based on the profile name. It is to make sure that the application displays the information accurately
    func testInitialsCreation() {
        //Create an instance of ProfileDetails and define the sample name
        let viewModel = ProfileDetails()
        let name = "Daniel La"
        
        // Call the saveInitials function with provided sample name
        let initials = viewModel.saveInitial(from: name)
        
        // Verifies that the formatting of the initials based on the sample name is extracted correctly
        XCTAssertEqual(initials, "DL", "Initials be DL")
    }
    
    
    // Test to that invalid profile name returns a nil when being passed through generating the initial function. It is important to prevent errors when users provide invalid names ensuring that the application has robust error handling
    func testInvalidInitialsCreation() {
        //Create an instance of ProfileDetails and define invalid the sample name
        let viewModel = ProfileDetails()
        let name = "1"
        
        // Call the saveInitials function with provided invalid sample name
        let initials = viewModel.saveInitial(from: name)
        
        // Verifies that the formatting of the initials based on the invalid sample name cannot be generated and returns a nil value
        XCTAssertNil(initials, "Initials be nil")
    }

        
}

