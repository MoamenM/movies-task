//
//  MoviesRequest.swift
//  TMDbMovies
//
//  Created by ELKHADRAGI Moamen on 04/06/2024.
//

import Foundation
import AppServices

/// Struct representing a request to fetch a list of movies.
struct MoviesRequest: Request {
    
    /// The type of data returned by the request.
    typealias ReturnType = MoviesList
    
    /// The path component of the URL for the request.
    var path: String
    
    /// The HTTP method used for the request.
    var method: HTTPMethod = .get
    
    init(path: String) {
        self.path = path
    }
}
