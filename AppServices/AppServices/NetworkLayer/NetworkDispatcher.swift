//
//  NetworkDispatcher.swift
//  AppServices
//
//  Created by ELKHADRAGI Moamen on 03/06/2024.
//

import Foundation
import Combine

/// A utility struct responsible for dispatching network requests and handling responses.
public struct NetworkDispatcher {
    
    /// The URLSession instance used for making network requests.
    public let urlSession: URLSession!
    
    /// Initializes a new NetworkDispatcher instance with the provided URLSession.
    /// - Parameter urlSession: The URLSession to use for network requests. Defaults to URLSession.shared.
    public init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    /// Dispatches a URLRequest and returns a publisher with the decoded data or an error.
    /// - Parameter request: The URLRequest to dispatch.
    /// - Returns: A publisher with the provided decoded data or an error.
    public func dispatch<ReturnType: Codable>(request: URLRequest) -> AnyPublisher<ReturnType, AppError> {
        return urlSession
            .dataTaskPublisher(for: request)
            // Map on Request response
            .tryMap({ data, response in
                // If the response is invalid, throw an error
                if let response = response as? HTTPURLResponse,
                   !(200...299).contains(response.statusCode) {
                    throw httpError(response.statusCode)
                }
                
                if let stringData = String(data: data, encoding: .utf8) {
                    print("Response Data: \(stringData)")
                } else {
                    print("Could not convert data to string")
                }
                
                // Return Response data
                return data
            })
            // Decode data using our ReturnType
            .decode(type: ReturnType.self, decoder: JSONDecoder())
            // Handle any decoding errors
            .mapError { error in
                handleError(error)
            }
            // And finally, expose our publisher
            .eraseToAnyPublisher()
    }
    
    /// Parses an HTTP status code and returns a proper error.
    /// - Parameter statusCode: The HTTP status code.
    /// - Returns: The mapped NetworkRequestError.
    private func httpError(_ statusCode: Int) -> AppError {
        switch statusCode {
        case 400: return .badRequest
        case 401: return .unauthorized
        case 403: return .forbidden
        case 404: return .notFound
        case 402, 405...499: return .error4xx(statusCode)
        case 500: return .serverError
        case 501...599: return .error5xx(statusCode)
        default: return .unknownError
        }
    }
    
    /// Parses URLSession Publisher errors and returns proper ones.
    /// - Parameter error: The URLSession publisher error.
    /// - Returns: A readable NetworkRequestError.
    private func handleError(_ error: Error) -> AppError {
        switch error {
        case is Swift.DecodingError:
            return .decodingError(error.localizedDescription)
        case let urlError as URLError:
            return .urlSessionFailed(urlError)
        case let error as AppError:
            return error
        default:
            return .unknownError
        }
    }
}
