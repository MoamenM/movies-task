//
//  Request+Extensions.swift
//  TMDbMovies
//
//  Created by ELKHADRAGI Moamen on 09/06/2024.
//

import Foundation
import AppServices

/// Extension of the `Request` protocol to include a base URL for the network requests.
extension Request {
    
    /// The base URL for network requests.
    var baseUrl: String { return "https://api.themoviedb.org" }
}
