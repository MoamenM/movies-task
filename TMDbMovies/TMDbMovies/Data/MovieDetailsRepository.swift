//
//  MovieDetailsRepository.swift
//  TMDbMovies
//
//  Created by ELKHADRAGI Moamen on 05/06/2024.
//

import Combine
import Foundation
import AppServices

/// A protocol defining the interface for fetching movie details.
protocol MovieDetailsRepositoryProtocol {
    
    /// Fetches movie details.
    /// - Returns: A publisher emitting a single movie or a network request error.
    func fetch() -> AnyPublisher<Movie, AppError>
}

/// A concrete implementation of `MovieDetailsRepositoryProtocol` responsible for fetching movie details.
class MovieDetailsRepository: MovieDetailsRepositoryProtocol {
    
    /// The network service responsible for making API requests.
    private let clientService: NetworkService
    
    /// The ID of the movie to fetch details for.
    private let movieId: Int

    /// Initializes a `MovieDetailsRepository` with the provided movie ID.
    /// - Parameter movieId: The ID of the movie to fetch details for.
    init(movieId: Int) {
        self.clientService = APIClient()
        self.movieId = movieId
    }

    /// Fetches movie details using an API request.
    /// - Returns: A publisher emitting a single movie or a network request error.
    func fetch() -> AnyPublisher<Movie, AppError> {
        clientService.dispatch(MovieDetailsRequest(movieId: movieId))
    }
}
