//
//  MoviesRepositoryProtocol.swift
//  TMDbMovies
//
//  Created by ELKHADRAGI Moamen on 09/06/2024.
//

import Combine
import AppServices

/// Protocol defining the requirements for a repository responsible for fetching a list of movies.
protocol MoviesRepositoryProtocol {
    
    /// Fetches a list of movies and returns a publisher with the result.
    ///
    /// - Returns: A publisher emitting either a `MoviesList` or a `AppError`.
    func fetch() -> AnyPublisher<MoviesList, AppError>
    
    /// Fetches a list of movies from the local storage.
    ///
    /// - Returns: An array of `MovieObject` fetched from the local storage.
    func fetchFromLocal() -> [MovieObject]
    
    /// Saves a list of movies fetched from a remote source to the local storage.
    ///
    /// - Parameter movies: An optional array of `Movie` objects to be saved to local storage.
    func saveRemoteMovies(movies: [Movie]?)
}
