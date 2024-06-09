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

extension MoviesList: ToEntity {

    func toEntity() -> MoviesListEntity {
        return MoviesListEntity(movies: results?.map({$0.toEntity()}))
    }
}

/// A struct representing a movie.
struct Movie: Codable {
    let id: Int?
    let title: String?
    let poster: String?
    let releaseDate: String?
    let genres: [Genre]?
    let overview: String?
    let runtime: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, genres, overview, runtime
        case title = "original_title"
        case releaseDate = "release_date"
        case poster = "poster_path"
    }
    
    init(id: Int, title: String?, poster: String?, releaseDate: String?) {
        self.id = id
        self.title = title
        self.poster = poster
        self.releaseDate = releaseDate
        self.genres = []
        self.overview = ""
        self.runtime = 0
    }
}


/// A struct representing a genre.
struct Genre: Codable {
    let id: Int?
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name
    }
}

extension Movie: ToEntity {

    func toEntity() -> MovieEntity {
        let genreNames = genres?.compactMap { $0.name}
        return MovieEntity(id: id, title: title, poster: poster, releaseDate: releaseDate,
                           genreNames: genreNames, overview: overview, runtime: runtime)
    }
}
