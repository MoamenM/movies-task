//
//  UIView+Extension.swift
//  AppUIKit
//
//  Created by ELKHADRAGI Moamen on 05/06/2024.
//

import UIKit

/// Extension providing convenience methods for rounding the corners of a UIView.
public extension UIView {
    
    /// Rounds the corners of the view with the specified corner radius.
    ///
    /// - Parameter cornerRadius: The radius to use when rounding the corners.
    func roundCorners(cornerRadius: CGFloat) {
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
    }
}
