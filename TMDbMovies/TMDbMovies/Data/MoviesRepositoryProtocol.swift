//
//  MoviesRepositoryProtocol.swift
//  TMDbMovies
//
//  Created by ELKHADRAGI Moamen on 04/06/2024.
//

import Combine
import Foundation
import AppServices

/// Protocol defining the requirements for a repository responsible for fetching a list of movies.
protocol MoviesListRepositoryProtocol {
    
    /// Fetches a list of movies and returns a publisher with the result.
    ///
    /// - Returns: A publisher emitting either a MoviesList or a NetworkRequestError.
    func fetch() -> AnyPublisher<MoviesList, NetworkRequestError>
}

/// Repository responsible for fetching a list of movies.
class MoviesListRepository: MoviesListRepositoryProtocol {
    
    /// The network service used for making requests.
    private let clientService: NetworkService
    
    /// The API path for fetching movies.
    private let path: String

    /// Initializes a new instance of MoviesListRepository with the provided API path.
    ///
    /// - Parameter path: The API path for fetching movies.
    init(path: String) {
        self.clientService = APIClient()
        self.path = path
    }

    /// Fetches a list of movies from the server.
    ///
    /// - Returns: A publisher emitting either a MoviesList or a NetworkRequestError.
    func fetch() -> AnyPublisher<MoviesList, NetworkRequestError> {
        clientService.dispatch(MoviesListRequest(path: path))
    }
    
}
