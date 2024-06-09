//
//  NetworkRequestError.swift
//  AppServices
//
//  Created by ELKHADRAGI Moamen on 03/06/2024.
//

import Foundation

/// An enumeration representing possible errors that can occur during network requests.
public enum AppError: LocalizedError, Equatable {
    
    /// Indicates a bad request.
    case badRequest
    
    /// Indicates an unauthorized access attempt.
    case unauthorized
    
    /// Indicates a forbidden access attempt.
    case forbidden
    
    /// Indicates that the requested resource was not found.
    case notFound
    
    /// Indicates a client error with a specific status code in the 4xx range.
    case error4xx(_ code: Int)
    
    /// Indicates a server error.
    case serverError
    
    /// Indicates a server error with a specific status code in the 5xx range.
    case error5xx(_ code: Int)
    
    /// Indicates an error occurred during decoding of response data.
    case decodingError( _ description: String)
    
    /// Indicates a failure in the URLSession.
    case urlSessionFailed(_ error: URLError)
    
    /// Indicates a timeout occurred during the request.
    case timeOut
    
    /// Indicates an unknown error occurred.
    case unknownError
    
    
    /// Returns a custom error message for each error case.
    public var localizedDescription: String {
        switch self {
        case .serverError:
            return "Sorry, Server Error."
        case .timeOut:
            return "Sorry, Request Timed Out."
        case .urlSessionFailed(let error):
            return error.localizedDescription
        default:
            return "Sorry, Something went wrong."
        }
    }
    
}
