//
//  MovieDetailsUseCase.swift
//  TMDbMovies
//
//  Created by ELKHADRAGI Moamen on 05/06/2024.
//

import Foundation
import Combine

/// A protocol defining the interface for fetching movie details asynchronously.
protocol MovieDetailsUseCaseInterface {
    
    /// Executes the asynchronous fetch operation to retrieve movie details.
    /// - Returns: A movie object if successful, or throws an error if an issue occurs during the operation.
    func executeFetchData() async throws -> MovieEntity?
}

/// A concrete implementation of `MovieDetailsUseCaseInterface` responsible for coordinating the retrieval of movie details.
class MovieDetailsUseCase: MovieDetailsUseCaseInterface {
    
    /// The repository responsible for fetching movie details.
    private let repo: MovieDetailsRepositoryProtocol
    
    /// A set to hold cancellable objects.
    private var cancellables = Set<AnyCancellable>()
    
    /// Initializes a `MovieDetailsUseCase` with the provided repository.
    /// - Parameter repo: The repository responsible for fetching movie details.
    public init(repo: MovieDetailsRepositoryProtocol) {
        self.repo = repo
    }
    
    /// Executes the asynchronous fetch operation to retrieve movie details.
    /// - Returns: A movie object if successful, or throws an error if an issue occurs during the operation.
    func executeFetchData() async throws -> MovieEntity? {
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
                    continuation.resume(returning: response.toEntity())
                }
                .store(in: &cancellables)
        }
    }
}
