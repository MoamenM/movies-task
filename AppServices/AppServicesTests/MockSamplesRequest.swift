//
//  MockSamplesRequest.swift
//  AppServicesTests
//
//  Created by ELKHADRAGI Moamen on 04/06/2024.
//

import XCTest
@testable import AppServices

/// A mock request struct for testing purposes.
struct MockSamplesRequest: Request {
    typealias ReturnType = Samples
    var path = String()
    var url: URL? {
        guard let bundle = Bundle.unitTest.path(forResource: "stub", ofType: "json") else {
            XCTFail("Error: content not found")
            return nil
        }
        return URL(fileURLWithPath: bundle)
    }
    var method: HTTPMethod = .get
}
