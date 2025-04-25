//
//  CarouselController.swift
//  UIKitGoogle
//
//  Created by Bill Nguyen on 12/10/2024.
//

import Foundation
import UIKit

/// A view controller that displays a carousel of nearby places using a `UICollectionView`.
///
/// `CarouselViewController` is a `UIViewController` subclass that manages a horizontally scrolling collection view
/// to display nearby places. Each place is shown in a custom `PlaceCollectionViewCell`, which includes an image and a title.
///
/// The collection view supports pagination and uses a flow layout with horizontal scrolling. Images for each place
/// are asynchronously fetched using the `PlacesManager`.
////// - Displays a horizontal carousel of places using a `UICollectionView`.
/// - Each cell in the collection view shows an image and name of a place.
/// - Uses `UICollectionViewDelegate`, `UICollectionViewDataSource`, and `UICollectionViewDelegateFlowLayout` protocols to manage data and layout.
///
/// ## Topics
/// ### Properties
/// - `nearbyplaces`: An array of `NearbyPlace` objects that represent the places to be displayed in the carousel.
/// - `carouselCollectionView`: A `UICollectionView` that displays the places in a horizontally scrolling layout.
///
/// ### Functions
/// - `viewDidLoad()`: Initializes the view controller and sets up the collection view and its constraints.
/// - `collectionView(_:numberOfItemsInSection:)`: Returns the number of items (places) in the carousel.
/// - `collectionView(_:cellForItemAt:)`: Configures and returns the cell for a place at a specific index.
/// - `collectionView(_:layout:sizeForItemAt:)`: Specifies the size of each carousel item.
///
/// ## Example Usage
/// ```swift
/// let carouselVC = CarouselViewController()
/// carouselVC.nearbyplaces = [NearbyPlace(name: "Central Park", photoReference: "CmRaAAA...")]
/// ```
class CarouselViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var nearbyplaces = [NearbyPlace]() // Data array for places
    
    /// The `UICollectionView` that displays the places in a horizontal, paginated carousel.

    var carouselCollectionView: UICollectionView!
    
    /// Sets up the collection view and its layout, configures the cell registration, and adds the collection view to the view hierarchy.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set up collection view layout

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        
        carouselCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        carouselCollectionView.translatesAutoresizingMaskIntoConstraints = false
        carouselCollectionView.backgroundColor = .clear
        carouselCollectionView.register(PlaceCollectionViewCell.self, forCellWithReuseIdentifier: "placeCell")
        carouselCollectionView.delegate = self
        carouselCollectionView.dataSource = self
        carouselCollectionView.isPagingEnabled = true
        carouselCollectionView.showsHorizontalScrollIndicator = false
        
        view.addSubview(carouselCollectionView)
        // Set up layout constraints for the collection view

        NSLayoutConstraint.activate([
            carouselCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            carouselCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            carouselCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            carouselCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    /// Returns the number of places to display in the carousel.
    ///
    /// - Parameters:
    ///   - collectionView: The collection view displaying the places.
    ///   - section: The section index (only one section is used here).
    /// - Returns: The number of nearby places in the `nearbyplaces` array.
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nearbyplaces.count
    }
    /// Configures and returns the cell for a place at the specified index.
        ///
        /// This method dequeues a reusable `PlaceCollectionViewCell` and sets its `nameLabel` with the name of the place.
        /// It also fetches the place's image using `PlacesManager`, and if the image is available, it is displayed in the `imageView`.
        /// A placeholder image is used if the photo reference is missing or the fetch fails.
        ///
        /// - Parameters:
        ///   - collectionView: The collection view requesting the cell.
        ///   - indexPath: The index path of the item in the collection.
        /// - Returns: A configured `PlaceCollectionViewCell` displaying the place's image and name.
       
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "placeCell", for: indexPath) as! PlaceCollectionViewCell
        let nearbyplace = nearbyplaces[indexPath.row]
        cell.nameLabel.text = nearbyplace.name
        
        if let photoReference = nearbyplace.photoReference {
            PlacesManager().getPlacePhoto(photoReference: photoReference) { image in
                DispatchQueue.main.async {
                    cell.imageView.image = image ?? UIImage(named: "placeholder")
                }
            }
        } else {
            cell.imageView.image = UIImage(named: "placeholder")
        }
        
        return cell
    }
    
    /// Specifies the size for each carousel item (cell) in the collection view.
     ///
     /// Each cell's width is set to 80% of the collection view's width, and the height is set to match the collection view's height.
     ///
     /// - Parameters:
     ///   - collectionView: The collection view displaying the items.
     ///   - collectionViewLayout: The layout object requesting the size information.
     ///   - indexPath: The index path of the item.
     /// - Returns: The size of the item (cell) as a `CGSize` object.
    /// 
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width * 0.8, height: collectionView.frame.height)
    }
}
