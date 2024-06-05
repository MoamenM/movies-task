//
//  CellViewModel.swift
//  AppUIKit
//
//  Created by ELKHADRAGI Moamen on 04/06/2024.
//

import Foundation

/// Protocol for defining view models used by table view cells.
public protocol CellViewModel {
    
    /// Identifier used to dequeue reusable table view cells.
    var reuseIdentifier: String { get }
    
    /// Height of the table view cell.
    var cellHeight: CGFloat { get }
}

// Default implementation for the CellViewModel protocol
public extension CellViewModel {
    
    /// Default implementation for the cell height property.
    ///
    /// By default, it returns 0.
    var cellHeight: CGFloat {
        return 0
    }
}
