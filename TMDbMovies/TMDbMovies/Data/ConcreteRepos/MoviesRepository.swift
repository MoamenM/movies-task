//
//  MoviesRepositoryProtocol.swift
//  TMDbMovies
//
//  Created by ELKHADRAGI Moamen on 04/06/2024.
//

import Combine
import Foundation
import AppServices

/// Repository responsible for fetching a list of movies.
class MoviesRepository: MoviesRepositoryProtocol {
    
    /// The network service used for making requests.
    private let clientService: NetworkService
    
    private var localClientService: MovieLocalRequestProtocol
    
    /// The API path for fetching movies.
    private let path: String
    
    /// The Type for fetching movies from coredate.
    private let type: String

    /// Initializes a new instance of MoviesRepository with the provided API path.
    ///
    /// - Parameter path: The API path for fetching movies.
    /// - Parameter type: The Type for fetching movies from coredate
    init(path: String, type: String) {
        self.clientService = APIClient()
        self.localClientService = MovieLocalRequest.shared
        self.path = path
        self.type = type
    }

    /// Fetches a list of movies from the server.
    ///
    /// - Returns: A publisher emitting either a MoviesList or a NetworkRequestError.
    func fetch() -> AnyPublisher<MoviesList, AppError> {
        clientService.dispatch(MoviesRequest(path: path))
    }
    
    /// Fetches a list of movies from the local storage.
    ///
    /// - Returns: An array of `MovieObject` fetched from the local storage.
    func fetchFromLocal() -> [MovieObject] {
        return localClientService.fetchMovies(type: type)
    }
    
    /// Saves a list of movies fetched from a remote source to the local storage.
    ///
    /// - Parameter movies: An optional array of `Movie` objects to be saved to local storage.
    func saveRemoteMovies(movies: [Movie]?) {
        for movie in movies ?? [] {
            guard let movieId = movie.id else { continue }
            localClientService.addMovie(type: type, id: movieId, title: movie.title,
                                 poster: movie.poster, releaseDate: movie.releaseDate)
        }
    }
}
