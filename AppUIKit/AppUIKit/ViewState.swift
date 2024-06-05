//
//  ViewState.swift
//  AppUIKit
//
//  Created by ELKHADRAGI Moamen on 05/06/2024.
//

import Foundation

/// Represents the various states of a view.
public enum ViewState {
    /// Indicates that loading is in progress and a loading indicator should be shown.
    case showLoading
    
    /// Indicates that loading has finished and the loading indicator should be hidden.
    case hideLoading
    
    /// Indicates that data has been successfully loaded and is ready to be displayed.
    case dataLoaded
    
    /// Indicates that an error has occurred and an error message should be displayed.
    ///
    /// - Parameters:
    ///   - imageName: Optional image name to be displayed along with the error message.
    ///   - message: The error message to be displayed.
    ///   - buttonTitle: Optional title for a button to be displayed along with the error message.
    ///   - buttonAction: Optional action closure to be executed when the button is tapped.
    case showError(imageName: String? = nil,
                    message: String,
                    buttonTitle: String? = nil,
                    buttonAction: (() -> Void)? = nil)
}
