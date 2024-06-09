//
//  MovieDetailsViewModelTests.swift
//  TMDbMoviesTests
//
//  Created by ELKHADRAGI Moamen on 05/06/2024.
//

import XCTest
import Combine
import AppServices
@testable import TMDbMovies

/// A test suite for testing the functionality of the AppServices module.
final class MovieDetailsViewModelTests: XCTestCase {
    
    private var sut: MovieDetailsViewModel!
    private var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        sut = MovieDetailsViewModel(useCase: nil)
        cancellables = .init()
    }
    
    override func tearDown() {
        sut = nil
        cancellables = nil
        super.tearDown()
    }
    
    
    /// Tests the setupMovieDetails method of the MovieDetailsViewModel.
    func testSetupMovieDetails() {
        
        // Given
        let genres = ["Science Fiction", "Action"]
        let movie = MovieEntity(id: 614933, title: "Atlas", poster: "/bcM2Tl5HlsvPBnL8DKP9Ie6vU4r", releaseDate: "2024-05-23", genreNames: genres, overview: "A brilliant counterterrorism analyst with a deep distrust of AI discovers it might be her only hope when a mission to capture a renegade robot goes awry.", runtime: 120)
        
        
        
        // When
        sut.setupMovieDetails(movie: movie)
        
        
        // Then
        XCTAssertNotNil(genres)
        XCTAssertNotNil(movie)
        XCTAssertEqual(sut.movieDetails.value?.poster, "https://image.tmdb.org/t/p/original/bcM2Tl5HlsvPBnL8DKP9Ie6vU4r")
        XCTAssertEqual(sut.movieDetails.value?.title, "Atlas")
        XCTAssertEqual(sut.movieDetails.value?.genres, "Science Fiction, Action")
        XCTAssertEqual(sut.movieDetails.value?.releaseDate, "2024-05-23")
        XCTAssertEqual(sut.movieDetails.value?.runTime, "02:00")
        XCTAssertEqual(sut.movieDetails.value?.overview, "A brilliant counterterrorism analyst with a deep distrust of AI discovers it might be her only hope when a mission to capture a renegade robot goes awry.")
    }
    
    
    /// Tests the notifyErrorState method of the MovieDetailsViewModel.
    func testNotifyErrorState() {
        
        // Given
        let error: AppError = .unknownError
        
        
        // When
        sut.notifyErrorState(error: error)
        
        
        // Then
        XCTAssertNotNil(error)
        sut.viewState.sink { viewState in
            switch viewState {
            case .showError(let imageName, let message, let buttonTitle, _):
                XCTAssertEqual(imageName, "ic_noMovies")
                XCTAssertEqual(message, "Sorry, Something went wrong")
                XCTAssertEqual(buttonTitle, "Try Again")
                XCTAssertEqual(imageName, "ic_noMovies")
            default:
                return
            }
        }.store(in: &cancellables)
    }
    
}
