//
//  UITableView+Extension.swift
//  AppUIKit
//
//  Created by ELKHADRAGI Moamen on 05/06/2024.
//

import UIKit

/// Extension providing convenience methods for registering UITableViewCell using class names.
public extension UITableView {
    
    /// Registers a UITableViewCell using its class name.
    ///
    /// - Parameter name: The UITableViewCell type.
    func register<T: UITableViewCell>(cellWithClass name: T.Type) {
        // Create a UINib using the provided cell class name
        let nib = UINib(nibName: String(describing: name), bundle: nil)
        // Register the UINib for the cell with the table view using the cell class name
        register(nib, forCellReuseIdentifier: String(describing: name))
    }
    
    func addEmptyView(imageName: String? = nil, message: String, buttonTitle: String? = nil, buttonAction: (()->Void)? = nil) {
        let emptyView = EmptyView()
        emptyView.configure(imageName: imageName, message: message, buttonTitle: buttonTitle, buttonAction: buttonAction)
        backgroundView = emptyView
    }
    
    func removeBackgroundView() {
        backgroundView = nil
    }
}
