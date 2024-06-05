//
//  UITableViewSection.swift
//  AppUIKit
//
//  Created by ELKHADRAGI Moamen on 05/06/2024.
//

import Foundation

/// A struct representing a section in a table or collection view.
public struct Section {
    
    /// The title for the header of the section.
    public var headerTitle: String?
    
    /// The title for the footer of the section.
    public var footerTitle: String?
    
    /// The height for the header of the section.
    public var headerHeight: CGFloat?
    
    /// The height for the footer of the section.
    public var footerHeight: CGFloat?
    
    /// The view model for the header of the section.
    public var headerCellViewModel: CellViewModel?
    
    /// The view model for the footer of the section.
    public var footerCellViewModel: CellViewModel?
    
    /// The array of cell view models representing the items in the section.
    public var items: [CellViewModel]
    
    /// Initializes a new instance of the Section struct.
    ///
    /// - Parameters:
    ///   - headerTitle: The title for the header of the section. Default is `nil`.
    ///   - footerTitle: The title for the footer of the section. Default is `nil`.
    ///   - headerHeight: The height for the header of the section. Default is `nil`.
    ///   - footerHeight: The height for the footer of the section. Default is `nil`.
    ///   - headerCellViewModel: The view model for the header of the section. Default is `nil`.
    ///   - footerCellViewModel: The view model for the footer of the section. Default is `nil`.
    ///   - items: The array of cell view models representing the items in the section.
    public init(headerTitle: String? = nil,
                footerTitle: String? = nil,
                headerHeight: CGFloat? = nil,
                footerHeight: CGFloat? = nil,
                headerCellViewModel: CellViewModel? = nil,
                footerCellViewModel: CellViewModel? = nil,
                items: [CellViewModel]) {
        self.headerTitle = headerTitle
        self.footerTitle = footerTitle
        self.headerHeight = headerHeight
        self.footerHeight = footerHeight
        self.headerCellViewModel = headerCellViewModel
        self.footerCellViewModel = footerCellViewModel
        self.items = items
    }
}

