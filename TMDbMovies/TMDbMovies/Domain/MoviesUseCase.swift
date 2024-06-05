//
//  MoviesUseCase.swift
//  TMDbMovies
//
//  Created by ELKHADRAGI Moamen on 04/06/2024.
//

import Foundation
import Combine

/// Protocol defining the requirements for a use case responsible for executing the fetch operation for movies.
protocol MoviesUseCaseInterface {
    
    /// Executes the fetch operation for movies asynchronously.
    ///
    /// - Returns: A MoviesList object representing the list of movies fetched.
    /// - Throws: An error if the fetch operation fails.
    func executeFetchData() async throws -> MoviesList?
}

/// Use case responsible for executing the fetch operation for movies.
class MoviesUseCase: MoviesUseCaseInterface {
    
    /// The repository used for fetching movies.
    private let repo: MoviesRepositoryProtocol
    
    /// Set of cancellables to manage subscriptions.
    private var cancellables = Set<AnyCancellable>()
    
    /// Initializes a new instance of MoviesUseCase with the provided repository.
    ///
    /// - Parameter repo: The repository used for fetching movies.
    public init(repo: MoviesRepositoryProtocol) {
        self.repo = repo
    }
    
    /// Executes the fetch operation for movies asynchronously.
    ///
    /// - Returns: A MoviesList object representing the list of movies fetched.
    /// - Throws: An error if the fetch operation fails.
    public func executeFetchData() async throws -> MoviesList? {
        return try await withCheckedThrowingContinuation { continuation in
            self.repo.fetch()
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                } receiveValue: { response in
                    continuation.resume(returning: response)
                }
                .store(in: &cancellables)
        }
    }
}
