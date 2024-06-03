//
//  Bundle+unitTests.swift
//  AppServicesTests
//
//  Created by ELKHADRAGI Moamen on 03/06/2024.
//

import Foundation

/// An extension on Bundle providing utility methods.
extension Bundle {
   
    /// Returns the bundle associated with the unit tests.
    class var unitTest: Bundle {
        return Bundle(for: APIClientTests.self)
    }
}
