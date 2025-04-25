import UIKit
/// A custom `UICollectionViewCell` designed to display an image with an overlaid title in a carousel.
///
/// `CarouselCollectionViewCell` is a reusable cell that contains:
/// - An `UIImageView` to display the main image.
/// - A `UILabel` that overlays the image to display a title with a semi-transparent background.
///
/// This cell is ideal for use in carousels where each item is represented by an image and a title, and is typically
/// used in a horizontally scrolling `UICollectionView`.
///
/// - The `imageView` fills the entire cell, displaying an image in a `scaleAspectFill` mode.
/// - The `titleLabel` is overlaid at the bottom of the image, with bold white text and a semi-transparent black background for readability.
///
/// ## Topics
/// ### Subviews
/// - `imageView`: An `UIImageView` that fills the cell's content view, displaying the image.
/// - `titleLabel`: A `UILabel` placed at the bottom of the image, showing the title with a semi-transparent background.
///
/// ### Initialization
/// - `init(frame:)`: Initializes the cell programmatically, sets up subviews, and applies layout constraints.
/// - `required init?(coder:)`: Not implemented, as the cell is designed to be used programmatically.
///
/// ## Example Usage
/// ```swift
/// let cell = CarouselCollectionViewCell()
/// cell.imageView.image = UIImage(named: "sampleImage")
/// cell.titleLabel.text = "Sample Title"
/// ```
///
/// ## Layout and Constraints
/// - The `imageView` is constrained to fill the entire cell.
/// - The `titleLabel` is constrained to the bottom of the `imageView` with a fixed height of 40 points, stretching across the width of the cell.
///
/// ## Code Documentation
class CarouselCollectionViewCell: UICollectionViewCell {

        /// The `UIImageView` used to display the image in the carousel.
        ///
        /// This image view is set to `scaleAspectFill` mode, ensuring that the image fills the view proportionally, and clips
        /// any content that exceeds the view's bounds.
        let imageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()

        /// The `UILabel` used to display the title over the image.
       /// The label is centered horizontally at the bottom of the image, with bold white text. It has a semi-transparent black
       /// background to ensure the text is readable over any image.
        let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.backgroundColor = UIColor.black.withAlphaComponent(0.5) // Semi-transparent background
        return label
    }()
    /// Initializes the cell programmatically and sets up the subviews and layout constraints.
    ///
    /// This method adds the `imageView` and `titleLabel` to the cell's `contentView`, ensuring that the image fills the entire cell
    /// and the label is positioned at the bottom of the image with a fixed height.
    ///
    /// - Parameter frame: The frame rectangle for the cell.
    override init(frame: CGRect) {
        super.init(frame: frame)

        // Add the imageView to the cell's contentView
        contentView.addSubview(imageView)

        // Add the titleLabel as an overlay on the imageView
        contentView.addSubview(titleLabel)

        // Constrain the imageView to the cell's edges
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])

        // Constrain the titleLabel to the bottom of the imageView
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 40) // Height for the overlay
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
