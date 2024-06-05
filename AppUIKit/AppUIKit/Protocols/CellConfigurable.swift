//
//  CellConfigurable.swift
//  AppUIKit
//
//  Created by ELKHADRAGI Moamen on 04/06/2024.
//

import Foundation

/// Protocol for configuring a table view cell with a view model.
public protocol CellConfigurable {
    
    /// Configures the table view cell with the provided view model.
    ///
    /// - Parameter cellViewModel: The view model containing data to configure the cell.
    func configure(with cellViewModel: CellViewModel)
}
