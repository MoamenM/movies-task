//
//  MovieDetailsViewController.swift
//  TMDbMovies
//
//  Created by ELKHADRAGI Moamen on 05/06/2024.
//

import UIKit
import Combine
import AppUIKit

/**
 View controller responsible for displaying movie details.
 */
class MovieDetailsViewController: UIViewController {
    
    // MARK: - Variables
    
    // Outlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var runtimeLabel: UILabel!
    @IBOutlet weak var overViewTextView: UITextView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    // Local Variables
    private let viewModel: MovieDetailsViewModel
    private var cancellables = Set<AnyCancellable>()
    private lazy var emptyView: EmptyView = {
        let emptyView = EmptyView()
        emptyView.frame = containerView.frame
        return emptyView
    }()
    
    // MARK: - Initialization
    
    /**
     Initializes the view controller with a view model.
     
     - Parameter viewModel: The view model containing movie details.
     */
    public init(with viewModel: MovieDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
        getMovieDetails()
    }
    
    // MARK: - Helper methods
    
    private func setupUI() {
        containerView.isHidden = true
    }
    
    private func setupBindings() {
        viewModel.viewState.sink { [weak self] state in
            guard let self = self else { return }
            switch state {
            case .showLoading:
                self.emptyView.removeFromSuperview()
                self.loadingIndicator.isHidden = false
                self.loadingIndicator.startAnimating()
            case .hideLoading:
                self.loadingIndicator.stopAnimating()
            case .dataLoaded:
                self.containerView.isHidden = false
            case .showError(let imageName, let message, let buttonTitle, let buttonAction):
                self.emptyView.configure(imageName: imageName, message: message,
                                         buttonTitle: buttonTitle, buttonAction: buttonAction)
                self.view.addSubview(self.emptyView)
            }
        }.store(in: &cancellables)
        
        viewModel.movieDetails.sink { [weak self] movieDetails in
            guard let self = self, let movieDetails = movieDetails else { return }
            self.posterImageView.loadImage(from: movieDetails.poster,
                                           placeholder: self.viewModel.posterImagePlaceHolderName)
            self.titleLabel.text = movieDetails.title
            self.genresLabel.text = movieDetails.genres
            self.releaseDateLabel.text = movieDetails.releaseDate
            self.runtimeLabel.text = movieDetails.runTime
            self.overViewTextView.text = movieDetails.overview
        }.store(in: &cancellables)
    }
    
    private func getMovieDetails() {
        viewModel.getMovieDetails()
    }
}
