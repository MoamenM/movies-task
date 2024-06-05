//
//  APIClient.swift
//  AppServices
//
//  Created by ELKHADRAGI Moamen on 03/06/2024.
//

import Foundation
import Combine

public protocol NetworkService {
    func dispatch<R: Request>(_ request: R) -> AnyPublisher<R.ReturnType, AppError>
}

/// A struct responsible for making API requests.
public struct APIClient: NetworkService {
    
    public init() { }
    
    /// The network dispatcher used for sending requests.
    public var networkDispatcher: NetworkDispatcher = NetworkDispatcher()
    
    /// Dispatches a Request and returns a publisher
    /// - Parameter request: Request to Dispatch
    /// - Returns: A publisher containing decoded data or an error
    public func dispatch<R: Request>(_ request: R) -> AnyPublisher<R.ReturnType, AppError> {
        
        // Convert request to URLRequest
        guard let url = request.url, let urlRequest = request.asURLRequest(url: url) else {
            // Return a Fail publisher with a bad request error if URL creation fails
            return Fail(outputType: R.ReturnType.self, failure: AppError.badRequest).eraseToAnyPublisher()
        }
        
        // Dispatch the URLRequest using the network dispatcher
        typealias RequestPublisher = AnyPublisher<R.ReturnType, AppError>
        let requestPublisher: RequestPublisher = networkDispatcher.dispatch(request: urlRequest)
        
        // Erase the publisher's type to AnyPublisher for abstraction
        return requestPublisher.eraseToAnyPublisher()
    }
}

