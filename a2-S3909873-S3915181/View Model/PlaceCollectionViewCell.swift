//
//  PlaceCollectionViewCell.swift
//
//  Created by Bill Nguyen on 12/10/2024.
//


import Foundation
import UIKit

/// A custom `UICollectionViewCell` for displaying a place's image and name in a carousel.
///
/// `PlaceCollectionViewCell` is a reusable cell designed for use in a `UICollectionView`. It includes:
/// - An `UIImageView` to display an image.
/// - A `UILabel` to display the name of the place, overlaid on the image with a semi-transparent background.
///
/// This cell is typically used in a carousel layout to display various places, with an image and its corresponding name.
///
/// - The `imageView` displays an image related to the place (e.g., a photo of the location).
/// - The `nameLabel` displays the name of the place on top of the image with a semi-transparent black background for enhanced readability.
///
/// ## Topics
/// ### Subviews
/// - `imageView`: A `UIImageView` that fills the cell to display the place's image.
/// - `nameLabel`: A `UILabel` placed at the bottom of the image, showing the place's name with white text and a semi-transparent black background.
///
/// ### Initialization
/// - `init(frame:)`: Initializes the cell programmatically, sets up subviews, and applies layout constraints.
/// - `required init?(coder:)`: Not implemented, as the cell is designed to be used programmatically.
///
/// ## Example Usage
/// ```swift
/// let cell = PlaceCollectionViewCell()
/// cell.imageView.image = UIImage(named: "placeImage")
/// cell.nameLabel.text = "Central Park"
/// ```
///
/// ## Layout and Constraints
/// - The `imageView` fills the entire content view of the cell.
/// - The `nameLabel` is placed at the bottom of the image and has a fixed height of 40 points, stretching across the width of the cell.
///
class PlaceCollectionViewCell: UICollectionViewCell {
    /// The `UIImageView` used to display the image of the place.
    /// This image view is set to `scaleAspectFill` mode, ensuring the image fills the view proportionally, and it clips any content that exceeds the view's bounds.
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    /// The `UILabel` used to display the name of the place over the image.
    ///
    /// The label is centered horizontally and displayed at the bottom of the image. It has bold white text, and its background is a semi-transparent black to ensure the text is readable over any image.
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        return label
    }()
    /// Initializes the cell and sets up the subviews and layout constraints.
   ///
   /// This initializer adds the `imageView` and `nameLabel` to the cell's `contentView`, ensuring that the image fills the entire cell and the label is positioned at the bottom of the image with a fixed height.
   ///
   /// - Parameter frame: The frame rectangle for the cell.
  
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
        
        //Constraints for imageView
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
        //Constraints for the nameLabel
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    /// This initializer is not implemented as the cell is designed to be used programmatically.
    /// - Parameter coder: An unarchiver object.
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
