//
//  APIClientTests.swift
//  APIClientTests
//
//  Created by ELKHADRAGI Moamen on 03/06/2024.
//

import XCTest
import Combine
@testable import AppServices


/// A test suite for testing the functionality of the AppServices module.
final class APIClientTests: XCTestCase {
    
    var sut: APIClient!
    var cancellables: Set<AnyCancellable> = []
    
    override func setUp() {
        super.setUp()
        sut = APIClient()
        cancellables = Set<AnyCancellable>()
    }
    
    override func tearDown() {
        sut = nil
        cancellables = []
        super.tearDown()
    }
    
    
    /// Tests the fetchSamples method of the APIClient.
    func testFetchSamples() {
        
        // Given
        let promise = XCTestExpectation(description: "Fetch sample completed")
        var responseError: Error?
        var responsePhotos: [Sample]?
        
        
        
        // When
        sut.dispatch(MockSamplesRequest())
            .sink(receiveCompletion: { networkState in
                switch networkState {
                case .finished:
                    promise.fulfill()
                case .failure(let error):
                    responseError = error
                }
                
                
            }, receiveValue: { serverResponse in
                responsePhotos = serverResponse.samples
            })
            .store(in: &cancellables)
        wait(for: [promise], timeout: 1)
        
        
        
        // Then
        XCTAssertNil(responseError)
        XCTAssertNotNil(responsePhotos)
    }
    
}



