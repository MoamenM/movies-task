//
//  MovieDetailsRepositoryProtocol.swift
//  TMDbMovies
//
//  Created by ELKHADRAGI Moamen on 09/06/2024.
//

import Combine
import AppServices

/// A protocol defining the interface for fetching movie details.
protocol MovieDetailsRepositoryProtocol {
    
    /// Fetches movie details.
    /// - Returns: A publisher emitting a single movie or a network request error.
    func fetch() -> AnyPublisher<Movie, AppError>
}
