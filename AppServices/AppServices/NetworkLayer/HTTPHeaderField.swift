//
//  HTTPHeaderField.swift
//  AppServices
//
//  Created by ELKHADRAGI Moamen on 03/06/2024.
//

import Foundation

/// An enumeration representing commonly used HTTP header fields.
enum HTTPHeaderField: String {
    
    /// The header field for authentication.
    case authentication = "Authentication"
    
    /// The header field for specifying the content type of the request.
    case contentType = "Content-Type"
    
    /// The header field for specifying the accepted content type by the client.
    case acceptType = "Accept"
    
    /// The header field for specifying the accepted encoding by the client.
    case acceptEncoding = "Accept-Encoding"
    
    /// The header field for specifying authorization credentials.
    case authorization = "Authorization"
    
    /// The header field for specifying the preferred language of the client.
    case acceptLanguage = "X-Locale"
    
}
