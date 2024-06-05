//
//  MoviesCoordinator.swift
//  TMDbMovies
//
//  Created by ELKHADRAGI Moamen on 05/06/2024.
//

import UIKit

protocol MoviesCoordinatorProtocol: Coordinator {
    func didSelectedMovie(with id: Int)
}


/// Class representing a tab coordinator.
class MoviesCoordinator: NSObject, MoviesCoordinatorProtocol {
    
    weak var finishDelegate: CoordinatorFinishDelegate?
    var tabBarPageType: TabBarPage?
        
    var childCoordinators: [Coordinator] = []

    var navigationController: UINavigationController
    
    var type: CoordinatorType { .movies }
    
    /// Initializes the tab coordinator with the given navigation controller.
    /// - Parameter navigationController: The navigation controller associated with the tab coordinator.
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    /// Starts the tab coordinator.
    func start() {
        // Determine the API path based on the selected page
        guard let tabBarPageType = tabBarPageType else { return }
        var path: String
        switch tabBarPageType {
        case .nowPlaying:
            path = "/3/movie/now_playing"
        case .popular:
            path = "/3/movie/popular"
        case .upcoming:
            path = "/3/movie/upcoming"
        }
        
        let repo = MoviesRepository(path: path)
        let useCase = MoviesUseCase(repo: repo)
        let viewModel = MoviesViewModel(title: tabBarPageType.pageTitleValue(),
                                        useCase: useCase, coordinator: self)
        let moviesVC = MoviesViewController(with: viewModel)
        navigationController.pushViewController(moviesVC, animated: true)
    }

    func didSelectedMovie(with id: Int) {
        let repo = MovieDetailsRepository(movieId: id)
        let useCase = MovieDetailsUseCase(repo: repo)
        let viewModel = MovieDetailsViewModel(useCase: useCase)
        let movieDetailsVC = MovieDetailsViewController(with: viewModel)
        navigationController.pushViewController(movieDetailsVC, animated: true)
    }

    
}
