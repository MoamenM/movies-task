//
//  MoviesViewController.swift
//  TMDbMovies
//
//  Created by ELKHADRAGI Moamen on 04/06/2024.
//

import UIKit
import AppUIKit
import Combine

/// View controller responsible for displaying a list of movies.
class MoviesViewController: UIViewController {
    
    // MARK: Variables
    // Outlests
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    // Local Variables
    private let viewModel: MoviesViewModel
    private var cancellables = Set<AnyCancellable>()
    
    
    // MARK: Initialization
    
    /// Initializes a new instance of MoviesViewController with the provided view model.
    ///
    /// - Parameter viewModel: The view model responsible for managing movie data.
    public init(with viewModel: MoviesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
        getMovies()
    }
    
    
    // MARK: Helper methods
    
    /// Sets up the user interface.
    private func setupUI() {
        title = viewModel.title
        loadingIndicator.hidesWhenStopped = true
        tableView.register(cellWithClass: MovieTableViewCell.self)
    }
    
    /// Sets up the bindings between the view model and the view controller.
    private func setupBindings() {
        viewModel.viewState.sink { [weak self] state in
            guard let self = self else { return }
            switch state {
            case .showLoading:
                tableView.removeBackgroundView()
                loadingIndicator.isHidden = false
                loadingIndicator.startAnimating()
            case .hideLoading:
                loadingIndicator.stopAnimating()
            case .dataLoaded:
                tableView.reloadData()
            case .showError(let imageName, let message, let buttonTitle, let buttonAction):
                tableView.addEmptyView(imageName: imageName, message: message,
                                       buttonTitle: buttonTitle, buttonAction: buttonAction)
            }
        }.store(in: &cancellables)
    }
    
    private func getMovies() {
        viewModel.getMovies()
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension MoviesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellViewModel = viewModel.cellViewModelAt(index: indexPath.row) else {
            return UITableViewCell()
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: cellViewModel.reuseIdentifier, for: indexPath)
        if let cell = cell as? CellConfigurable {
            cell.configure(with: cellViewModel)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.heightForRowAt(index: indexPath.row)
    }
    
}
