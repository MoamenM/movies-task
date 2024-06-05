//
//  TabCoordinator.swift
//  TMDbMovies
//
//  Created by ELKHADRAGI Moamen on 04/06/2024.
//

import UIKit

/// Enum representing the pages available in the tab bar.
enum TabBarPage {
    case nowPlaying
    case popular
    case upcoming
    
    /// Initializes a `TabBarPage` enum from the given index.
    /// - Parameter index: The index representing the tab page.
    init?(index: Int) {
        switch index {
        case 0:
            self = .nowPlaying
        case 1:
            self = .popular
        case 2:
            self = .upcoming
        default:
            return nil
        }
    }
    
    /// Returns the order number of the tab page.
    func pageOrderNumber() -> Int {
        switch self {
        case .nowPlaying:
            return 0
        case .popular:
            return 1
        case .upcoming:
            return 2
        }
    }
    
    /// Returns the title value of the tab page.
    func pageTitleValue() -> String {
        switch self {
        case .nowPlaying:
            return "Now Playing"
        case .popular:
            return "Popular"
        case .upcoming:
            return "Upcoming"
        }
    }
    
    /// Returns the icon of the tab page.
    func pageIcon() -> UIImage? {
        switch self {
        case .nowPlaying:
            return UIImage(systemName: "play")
        case .popular:
            return UIImage(systemName: "party.popper")
        case .upcoming:
            return UIImage(systemName: "play.rectangle.on.rectangle")
        }
    }
}


/// Protocol defining the behavior of a tab coordinator.
protocol TabCoordinatorProtocol: Coordinator {
    var tabBarController: UITabBarController { get set }
    
    func selectPage(_ page: TabBarPage)
    
    func setSelectedIndex(_ index: Int)
    
    func currentPage() -> TabBarPage?
}


/// Class representing a tab coordinator.
class TabCoordinator: NSObject, Coordinator {
    weak var finishDelegate: CoordinatorFinishDelegate?
        
    var childCoordinators: [Coordinator] = []

    var navigationController: UINavigationController
    
    var tabBarController: UITabBarController

    var type: CoordinatorType { .tab }
    
    /// Initializes the tab coordinator with the given navigation controller.
    /// - Parameter navigationController: The navigation controller associated with the tab coordinator.
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.tabBarController = .init()
        tabBarController.tabBar.tintColor = .orange
        tabBarController.tabBar.unselectedItemTintColor = .gray
        tabBarController.tabBar.backgroundColor = .black
    }

    /// Starts the tab coordinator.
    func start() {
        let pages: [TabBarPage] = [.upcoming, .popular, .nowPlaying]
            .sorted(by: { $0.pageOrderNumber() < $1.pageOrderNumber() })
        
        let controllers: [UINavigationController] = pages.map({ getTabController($0) })
        
        prepareTabBarController(withTabControllers: controllers)
    }
    
    /// Prepares the tab bar controller with the given tab controllers.
    /// - Parameter tabControllers: The view controllers for the tab bar.
    private func prepareTabBarController(withTabControllers tabControllers: [UIViewController]) {
        tabBarController.delegate = self
        tabBarController.setViewControllers(tabControllers, animated: true)
        tabBarController.selectedIndex = TabBarPage.nowPlaying.pageOrderNumber()
        tabBarController.tabBar.isTranslucent = false
        
        navigationController.viewControllers = [tabBarController]
    }
      
    /// Retrieves the navigation controller for the specified tab page.
    /// - Parameter page: The tab page for which to retrieve the navigation controller.
    /// - Returns: The navigation controller associated with the tab page.
    private func getTabController(_ page: TabBarPage) -> UINavigationController {
        let navController = UINavigationController()
        navController.setNavigationBarHidden(false, animated: false)

        // Create a tab bar item for the page
        navController.tabBarItem = UITabBarItem(title: page.pageTitleValue(),
                                                image: page.pageIcon(),
                                                tag: page.pageOrderNumber())
        
        // Determine the API path based on the selected page
        var path: String
        var title: String
        switch page {
        case .nowPlaying:
            path = "/3/movie/now_playing"
            title = "Now Playing Movies"
        case .popular:
            path = "/3/movie/popular"
            title = "Popular Movies"
        case .upcoming:
            path = "/3/movie/upcoming"
            title = "Upcoming Movies"
        }
        
        let repo = MoviesListRepository(path: path)
        let useCase = MoviesListUseCase(repo: repo)
        let viewModel = MoviesViewModel(title: title, useCase: useCase)
        let moviesVC = MoviesViewController(with: viewModel)
        navController.pushViewController(moviesVC, animated: true)
        
        return navController
    }
    
    /// Returns the currently selected tab page.
    /// - Returns: The currently selected tab page.
    func currentPage() -> TabBarPage? {
        TabBarPage(index: tabBarController.selectedIndex)
    }

    /// Selects the specified tab page.
    /// - Parameter page: The tab page to select.
    func selectPage(_ page: TabBarPage) {
        tabBarController.selectedIndex = page.pageOrderNumber()
    }
    
    /// Sets the selected index of the tab bar.
    /// - Parameter index: The index to set.
    func setSelectedIndex(_ index: Int) {
        guard let page = TabBarPage(index: index) else { return }
        
        tabBarController.selectedIndex = page.pageOrderNumber()
    }
}

// MARK: - UITabBarControllerDelegate
extension TabCoordinator: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController,
                          didSelect viewController: UIViewController) {
        // Some implementation
    }
}
