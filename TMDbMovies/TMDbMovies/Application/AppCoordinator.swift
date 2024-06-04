//
//  AppCoordinator.swift
//  TMDbMovies
//
//  Created by ELKHADRAGI Moamen on 04/06/2024.
//

import UIKit

/// Protocol defining the behavior of the main application coordinator.
protocol AppCoordinatorProtocol: Coordinator {
    
    /// Presents the main flow of the application.
    func showMainFlow()
}

/// Class representing the main application coordinator.
class AppCoordinator: AppCoordinatorProtocol {
    
    /// Weak reference to the coordinator finish delegate.
    weak var finishDelegate: CoordinatorFinishDelegate?
    
    /// The navigation controller managed by the coordinator.
    var navigationController: UINavigationController
    
    /// Array holding references to child coordinators.
    var childCoordinators = [Coordinator]()
    
    /// The type of the coordinator.
    var type: CoordinatorType { .app }
        
    /// Initializes the application coordinator with the given navigation controller.
    /// - Parameter navigationController: The navigation controller to be managed by the coordinator.
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.setNavigationBarHidden(true, animated: true)
    }

    /// Starts the application coordinator by presenting the main flow.
    func start() {
        showMainFlow()
    }
    
    /// Presents the main flow of the application by initiating the tab coordinator.
    func showMainFlow() {
        let tabCoordinator = TabCoordinator(navigationController)
        tabCoordinator.finishDelegate = self
        tabCoordinator.start()
        childCoordinators.append(tabCoordinator)
    }
}

extension AppCoordinator: CoordinatorFinishDelegate {
    
    /// Handles the finishing of child coordinators.
    /// - Parameter childCoordinator: The child coordinator that finished.
    func coordinatorDidFinish(childCoordinator: Coordinator) {
        childCoordinators = childCoordinators.filter({ $0.type != childCoordinator.type })

        switch childCoordinator.type {
        case .tab:
            navigationController.viewControllers.removeAll()
        default:
            break
        }
    }
}
