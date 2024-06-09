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
    func executeFetchData() async throws -> [MovieEntity]?
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
    public func executeFetchData() async throws -> [MovieEntity]? {
        return try await withCheckedThrowingContinuation { continuation in
            self.repo.fetch()
                .sink { [weak self] completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        if let movies = self?.repo.fetchFromLocal(), !movies.isEmpty {
                            continuation.resume(returning: movies.map({$0.toEntity()}))
                        } else {
                            continuation.resume(throwing: error)
                        }
                    }
                } receiveValue: { [weak self] response in
                    self?.repo.saveRemoteMovies(movies: response.results)
                    continuation.resume(returning: response.toEntity().movies)
                }
                .store(in: &cancellables)
        }
    }
}
