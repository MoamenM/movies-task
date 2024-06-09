//
//  MoviesViewModelTests.swift
//  TMDbMoviesTests
//
//  Created by ELKHADRAGI Moamen on 06/06/2024.
//

import XCTest
import Combine
import AppServices
@testable import TMDbMovies

/// A test suite for testing the functionality of the AppServices module.
final class MoviesViewModelTests: XCTestCase {
    
    private var sut: MoviesViewModel!
    private var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        sut = MoviesViewModel(title: "Now Playing Movies", useCase: nil, coordinator: nil)
        cancellables = .init()
    }
    
    override func tearDown() {
        sut = nil
        cancellables = nil
        super.tearDown()
    }
    
    
    /// Tests the setupMovieCellViewModels method of the MoviesViewModel.
    func testsetupMovieCellViewModels() {
        
        // Given
        let genres = ["Science Fiction", "Action"]
        
        let atlasMovie = MovieEntity(id: 614933, title: "Atlas", poster: "/bcM2Tl5HlsvPBnL8DKP9Ie6vU4r", releaseDate: "2024-05-23", genreNames: genres, overview: "A brilliant counterterrorism analyst with a deep distrust of AI discovers it might be her only hope when a mission to capture a renegade robot goes awry.", runtime: 120)
        
        let jokerMovie = MovieEntity(id: 133792, title: "The Joker Is Wild", poster: "/brxoc8xjWRWGoRMGLy1NV59LeYF.jpg", releaseDate: "1957-09-26", genreNames: genres, overview: "Frank Sinatra stars in director Charles Vidor's 1957 film biography of nightclub entertainer Joe E. Lewis. The cast also includes Mitzi Gaynor, Jeanne Crain, Eddie Albert, Beverly Garland, Jackie Coogan, Harold Huber, Barry Kelley, Ted de Corsia, Ned Glass, Mary Treen and Sid Melton.", runtime: 190)
        
        
        // When
        sut.setupMovieCellViewModels(movies: [atlasMovie, jokerMovie])
        
        
        // Then
        XCTAssertNotNil(genres)
        XCTAssertNotNil(atlasMovie)
        XCTAssertNotNil(jokerMovie)
        XCTAssertNotNil(sut.moviesSection)
        XCTAssertEqual(sut.moviesSection?.items.count, 2)
    }
    
    
    /// Tests the notifyErrorState method of the MoviesViewModel.
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

