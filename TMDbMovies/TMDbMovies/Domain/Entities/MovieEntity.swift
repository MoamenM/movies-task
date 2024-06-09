//
//  MovieEntity.swift
//  TMDbMovies
//
//  Created by ELKHADRAGI Moamen on 09/06/2024.
//

import Foundation

struct MoviesListEntity {
    let movies: [MovieEntity]?
}

struct MovieEntity {
    let id: Int?
    let title: String?
    let poster: String?
    let releaseDate: String?
    let genreNames: [String]?
    let overview: String?
    let runtime: Int?
    
    init(id: Int?, title: String?, poster: String?, releaseDate: String?, genreNames: [String]? = nil, overview: String? = nil, runtime: Int? = nil) {
        self.id = id
        self.title = title
        self.poster = poster
        self.releaseDate = releaseDate
        self.genreNames = genreNames
        self.overview = overview
        self.runtime = runtime
    }
}
