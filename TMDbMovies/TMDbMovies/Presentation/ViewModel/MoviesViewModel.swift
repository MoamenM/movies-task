//
//  MoviesViewModel.swift
//  TMDbMovies
//
//  Created by ELKHADRAGI Moamen on 04/06/2024.
//

import Foundation
import Combine
import AppUIKit
import AppServices

class MoviesViewModel {
    
    // MARK: Variables
    private (set) var title: String
    private let useCase: MoviesUseCaseInterface?
    private let coordinator: MoviesCoordinatorProtocol?
    private (set) var viewState = PassthroughSubject<ViewState, Never>()
    private (set) var moviesSection: Section?
    
    // Computed variables
    /// Computed property that returns the number of rows in the section.
    var numberOfRows: Int {
        guard let section = moviesSection else { return 0}
        return section.items.count
    }
    
    
    // MARK: Initialization
    
    /// Initializes a new instance of MoviesViewModel with the provided title and use case.
    ///
    /// - Parameters:
    ///   - title: The title displayed in the view associated with this view model.
    ///   - useCase: The use case responsible for fetching movies.
    ///   - coordinator: the coordinator for handle naviagtion .
    public init(title: String,
                useCase: MoviesUseCaseInterface?,
                coordinator: MoviesCoordinatorProtocol?) {
        self.title = title
        self.useCase = useCase
        self.coordinator = coordinator
    }
    
    
    // MARK: Helper methods
    
    /// Get the height for the row at the specified index.
    ///
    /// - Parameter index: The index of the row.
    /// - Returns: The height of the row at the specified index.
    func heightForRowAt(index: Int) -> CGFloat {
        guard let section = moviesSection else { return 0}
        return section.items[index].cellHeight
    }
    
    /// Retrieves the cell view model at the specified index.
    ///
    /// - Parameter index: The index of the cell view model.
    /// - Returns: The cell view model at the specified index, or nil if the index is out of bounds or if the movies section is nil.
    func cellViewModelAt(index: Int) -> CellViewModel? {
        return moviesSection?.items[index]
    }
    
    func getMovies() {
        Task {
            await fetchMovies()
        }
    }
    
    /// Fetches movies asynchronously.
    private func fetchMovies() async {
        do {
            DispatchQueue.main.async { [weak self] in
                self?.viewState.send(.showLoading)
            }
            let result = try await useCase?.executeFetchData()
            setupMovieCellViewModels(movies: result)

            
            DispatchQueue.main.async { [weak self] in
                self?.viewState.send(.hideLoading)
                self?.viewState.send(.dataLoaded)
            }
            
        } catch let error  {
            DispatchQueue.main.async { [weak self] in
                self?.viewState.send(.hideLoading)
                let error = (error as? AppError) ?? .unknownError
                self?.notifyErrorState(error: error)
            }
        }
    }
    
    /// Sets up movie cell view models based on the provided movie data.
    ///
    /// - Parameter movies: An array of Movie objects representing the movies to be displayed.
    func setupMovieCellViewModels(movies: [MovieEntity]?) {
        guard let movies = movies else {
            notifyErrorState(error: .unknownError)
            return
        }
        
    
        let movieVMs: [CellViewModel] = movies.map { movie in
            return MovieCellViewModel(title: movie.title,
                                      releaseDate: movie.releaseDate,
                                      posterImage: movie.poster, selcteMovieAction: { [weak self] in
                guard let self = self, let movieId = movie.id else { return }
                coordinator?.didSelectedMovie(with: movieId)
            })
        }
        moviesSection = Section(items: movieVMs)
    }
    
    /// Notify the error state with the provided error message.
    ///
    /// - Parameter error: The AppError  to be displayed.
    func notifyErrorState(error: AppError) {
        viewState.send(.showError(imageName: "ic_noMovies", message: error.localizedDescription,
                                  buttonTitle: "Try Again", buttonAction: { [weak self] in
            self?.getMovies()
        }))
    }
}
