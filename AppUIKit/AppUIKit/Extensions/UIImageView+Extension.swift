//
//  UIImageView+Extension.swift
//  AppUIKit
//
//  Created by ELKHADRAGI Moamen on 05/06/2024.
//

import UIKit

/// Extension providing methods for loading images asynchronously into UIImageView with caching support.
public extension UIImageView {
    
    /// Cache for storing loaded images.
    private static let imageCache = NSCache<NSString, UIImage>()

    /// Loads an image asynchronously from the specified URL string and sets it to the image view.
    ///
    /// - Parameters:
    ///   - urlString: The URL string of the image to be loaded.
    ///   - placeholder: Optional name of the placeholder image to be displayed while loading.
    func loadImage(from urlString: String, placeholder: String? = nil) {
        // Show activity indicator while loading
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        activityIndicator.startAnimating()

        // Check if the image is available in the cache
        if let cachedImage = UIImageView.imageCache.object(forKey: urlString as NSString) {
            // Stop activity indicator
            activityIndicator.stopAnimating()
            // Set cached image
            self.image = cachedImage
            return
        }

        // Set placeholder image if provided
        if let placeholder = placeholder {
            self.image = UIImage(named: placeholder)
        }

        // Create URL from the provided string
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }

        // Perform the asynchronous image loading task
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self else { return }

            // Hide activity indicator
            DispatchQueue.main.async {
                activityIndicator.stopAnimating()
            }

            // Check for errors
            if let error = error {
                print("Error loading image: \(error)")
                return
            }

            // Check if there is data
            guard let data = data, let image = UIImage(data: data) else {
                print("Invalid image data")
                return
            }

            // Cache the image
            UIImageView.imageCache.setObject(image, forKey: urlString as NSString)

            // Update UI on the main thread
            DispatchQueue.main.async {
                self.image = image
            }
        }

        // Start the data task
        task.resume()
    }
}
