//
//  MovieTableViewCell.swift
//  TMDbMovies
//
//  Created by ELKHADRAGI Moamen on 04/06/2024.
//

import UIKit
import AppUIKit

/// Custom table view cell for displaying movie information.
class MovieTableViewCell: UITableViewCell, CellConfigurable {
    
    // MARK: Outlets
    
    /// Image view displaying the movie poster.
    @IBOutlet weak var movieImageView: UIImageView!
    
    /// Label displaying the movie title.
    @IBOutlet weak var movieTitleLabel: UILabel!
    
    /// Label displaying the movie release date.
    @IBOutlet weak var movieReleaseDate: UILabel!
    
    /// Performs any additional setup after the view has been loaded from its nib file.
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    /// A closure property representing an action to be executed when a movie is selected.
    private var selcteMovieAction: (()->Void)?

    /// Sets the selected state of the cell, optionally animating the transition between states.
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    // MARK: Helper methods
    
    /// Configures the appearance of the cell.
    private func setupUI() {
        movieImageView.roundCorners(cornerRadius: 8.0)
    }
    
    
    // MARK: CellConfigurable protocol conformance
    
    /// Configures the cell with the provided cellViewModel.
    ///
    /// - Parameter cellViewModel: The view model containing movie information.
    func configure(with cellViewModel: CellViewModel) {
        guard let cellViewModel = cellViewModel as? MovieCellViewModel else {
            return
        }
        
        movieTitleLabel.text = cellViewModel.title
        movieReleaseDate.text = cellViewModel.releaseDate
        movieImageView.loadImage(from: cellViewModel.posterImageURLString,
                                 placeholder: cellViewModel.posterImagePlaceHolderName)
        selcteMovieAction = cellViewModel.selcteMovieAction
    }
    
    // MARK:  Actions
    @IBAction private func selectMovieButtonTapped(_ sender: Any) {
        selcteMovieAction?()
    }
}
