//
//  MovieDetailsViewModel.swift
//  TMDbMovies
//
//  Created by ELKHADRAGI Moamen on 05/06/2024.
//

import Foundation
import Combine
import AppUIKit
import AppServices

/**
 View model responsible for managing movie details.
 */
class MovieDetailsViewModel {
    
    // MARK: - Variables
    
    private let useCase: MovieDetailsUseCaseInterface?
    private (set) var viewState = PassthroughSubject<ViewState, Never>()
    private (set) var movieDetails = CurrentValueSubject<(poster: String, title: String, genres: String,
                                                          releaseDate: String, runTime: String,
                                                          overview: String)?, Never>(nil)
    
    /// Name of the placeholder image to be used if the poster image is not available.
    var posterImagePlaceHolderName: String {
        return "ic_noImage"
    }
    
    
    // MARK: - Initialization
    
    /**
     Initializes the view model with a use case.
     
     - Parameter useCase: The use case for fetching movie details.
     */
    public init(useCase: MovieDetailsUseCaseInterface?) {
        self.useCase = useCase
    }
    
    
    // MARK: - Helper methods
    
    /**
     Fetches movie details.
     */
    func getMovieDetails() {
        Task {
            await fetchMovieDetails()
        }
    }
    
    /**
     Fetches movie details asynchronously.
     */
    private func fetchMovieDetails() async {
        do {
            DispatchQueue.main.async { [weak self] in
                self?.viewState.send(.showLoading)
            }
            let result = try await useCase?.executeFetchData()
            DispatchQueue.main.async { [weak self] in
                self?.viewState.send(.hideLoading)
                self?.setupMovieDetails(movie: result)
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
    
    /**
     Sets up movie details based on the provided movie.
     
     - Parameter movie: The movie object containing details.
     */
    func setupMovieDetails(movie: MovieEntity?) {
        guard let movie = movie else {
            notifyErrorState(error: .unknownError)
            return
        }
        
        let posterImageURLString = Constants.serverImageBasedURL + (movie.poster ?? "")
        let genreTitles = (movie.genreNames ?? []).joined(separator: ", ")
        let hours = (movie.runtime ?? 0) / 60
        let minutes = (movie.runtime ?? 0) % 60
        let formattedRunTime = String(format: "%02d:%02d", hours, minutes)

        movieDetails.value = (posterImageURLString, movie.title ?? "", genreTitles, movie.releaseDate ?? "", formattedRunTime, movie.overview ?? "")
    }
    
    /**
     Notifies the view state of an error state.
     
     - Parameter error: The error that occurred.
     */
    func notifyErrorState(error: AppError) {
        viewState.send(.showError(imageName: "ic_noMovies", message: error.localizedDescription,
                                  buttonTitle: "Try Again", buttonAction: { [weak self] in
            self?.getMovieDetails()
        }))
    }
    
}
