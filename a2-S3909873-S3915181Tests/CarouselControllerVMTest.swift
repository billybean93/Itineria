//
//  CarouselControllerVMTest.swift
//  a2-S3909873-S3915181Tests
//
//  Created by Daniel La on 12/10/2024.
//

import XCTest
@testable import a2_S3909873_S3915181
final class CarouselControllerVMTest: XCTestCase {

    // Test to verify the number of Items calculated by the Collection View Function is returning the correct number. It is important as it demonstrates that the number of populated items is being accurately reflected when being processed in the data model. Incorrect count of items can lead to unexpected behaviours, possibly displaying too few, too many or no cells
    func testNumberOfItems() {
        // Create an instance of CarouselViewController
        let viewModel = CarouselViewController()
        
        // Define a sample array containing 3 Instances of Nearby Place.
        viewModel.nearbyplaces = [
            NearbyPlace(id: "1", name: "Place 1", photoReference: nil),
            NearbyPlace(id: "2", name: "Place 2", photoReference: nil),
            NearbyPlace(id: "3", name: "Place 3", photoReference: nil),
        ]
        
        // Created a Mock UICollectionView
        let mockCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
               
        // Call the Collection View function, which determines how many items we have in the section
        let carouselCount = viewModel.collectionView(mockCollectionView, numberOfItemsInSection: 0)
        
        // Verifies that the number of items when providing our sample data is equal to 3
        XCTAssertEqual(carouselCount, 3)
    }


}
