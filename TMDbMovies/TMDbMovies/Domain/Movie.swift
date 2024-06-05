//
//  Movie.swift
//  TMDbMovies
//
//  Created by ELKHADRAGI Moamen on 04/06/2024.
//

import Foundation

/// A struct representing a list of movies returned from the server.
struct MoviesList: Codable {
    let page: Int?
    let results: [Movie]?
}


/// A struct representing a movie.
struct Movie: Codable {
    let id: Int?
    let title: String?
    let poster: String?
    let releaseDate: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title = "original_title"
        case releaseDate = "release_date"
        case poster = "poster_path"
    }
}