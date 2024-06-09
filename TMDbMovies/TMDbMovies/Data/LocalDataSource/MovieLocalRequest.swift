//
//  MovieLocalRequest.swift
//  TMDbMovies
//
//  Created by ELKHADRAGI Moamen on 06/06/2024.
//

import Foundation
import AppServices
import CoreData

/// Protocol defining the requirements for local movie requests.
protocol MovieLocalRequestProtocol {
    
    /// Fetches movies of a specific type from local storage.
    ///
    /// - Parameter type: The type of movies to fetch.
    /// - Returns: An array of `MovieObject` corresponding to the specified type.
    func fetchMovies(type: String) -> [MovieObject]
    
    /// Adds a movie to the local storage if it does not already exist.
    ///
    /// - Parameters:
    ///   - type: The type of the movie.
    ///   - id: The unique identifier of the movie.
    ///   - title: The title of the movie.
    ///   - poster: The poster image URL of the movie.
    ///   - releaseDate: The release date of the movie.
    func addMovie(type: String, id: Int, title: String?, poster: String?, releaseDate: String?)
}

/// Class implementing the `MovieLocalRequestProtocol` to manage local movie requests using Core Data.
class MovieLocalRequest: MovieLocalRequestProtocol {
    
    /// Shared singleton instance of `MovieLocalRequest`.
    static let shared: MovieLocalRequestProtocol = MovieLocalRequest()
    
    /// Helper instance for managing Core Data operations.
    var coreDataHelper: CoreDataHelper = CoreDataHelper.initializeSharedInstance(modelName: "TMDbMovies")
    
    /// Private initializer to enforce singleton pattern.
    private init() { }
    
    /// Fetches movies of a specific type from local storage.
    ///
    /// - Parameter type: The type of movies to fetch.
    /// - Returns: An array of `MovieObject` corresponding to the specified type.
    func fetchMovies(type: String) -> [MovieObject] {
        let predicate = NSPredicate(format: "listType == %@", type)
        let result: Result<[MovieObject], Error> = coreDataHelper.fetch(MovieObject.self, predicate: predicate)
        
        switch result {
        case .success(let cdMovies):
            return cdMovies
        case .failure(let error):
            print("Fetch movies failed with error: \(error.localizedDescription)")
            return []
        }
    }
    
    /// Adds a movie to the local storage if it does not already exist.
    ///
    /// - Parameters:
    ///   - type: The type of the movie.
    ///   - id: The unique identifier of the movie.
    ///   - title: The title of the movie.
    ///   - poster: The poster image URL of the movie.
    ///   - releaseDate: The release date of the movie.
    func addMovie(type: String, id: Int, title: String?, poster: String?, releaseDate: String?) {
        let predicate = NSPredicate(format: "id == %d AND listType == %@", "\(id)", type)
        let result: Result<[MovieObject], Error> = coreDataHelper.fetch(MovieObject.self, predicate: predicate)
        
        if case .success(let cdMovies) = result, cdMovies.isEmpty {
            let entity = MovieObject.entity()
            let newMovie = MovieObject(entity: entity, insertInto: coreDataHelper.context)
            newMovie.listType = type
            newMovie.id = "\(id)"
            newMovie.title = title
            newMovie.poster = poster
            newMovie.releaseDate = releaseDate
            coreDataHelper.create(newMovie)
        }
    }
}
