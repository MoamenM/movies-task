//
//  MovieDetailsRequest.swift
//  TMDbMovies
//
//  Created by ELKHADRAGI Moamen on 05/06/2024.
//

import Foundation
import AppServices

/// Struct representing a request to fetch the movie details.
struct MovieDetailsRequest: Request {
    
    /// The type of data returned by the request.
    typealias ReturnType = Movie
    
    /// The path component of the URL for the request.
    var path: String 
    
    /// The HTTP method used for the request.
    var method: HTTPMethod = .get
    
    init(movieId: Int) {
        self.path = "/3/movie/\(movieId)"
    }
}
