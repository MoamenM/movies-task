//
//  MovieCellViewModel.swift
//  TMDbMovies
//
//  Created by ELKHADRAGI Moamen on 04/06/2024.
//

import Foundation
import AppUIKit

/// View model representing movie information for a table view cell.
class MovieCellViewModel: CellViewModel {
    
    // MARK: Properties
    
    /// Reuse identifier for the corresponding table view cell.
    var reuseIdentifier: String {
        return String(describing: MovieTableViewCell.self)
    }
    
    /// Height of the cell.
    var cellHeight: CGFloat {
        return 100.0
    }
    
    /// Name of the placeholder image to be used if the poster image is not available.
    var posterImagePlaceHolderName: String {
        return "ic_noImage"
    }
    
    /// URL string for the movie poster image.
    var posterImageURLString: String {
        return Constants.serverImageBasedURL + posterImage
    }

    
    // MARK: Injected Properties
    
    /// Title of the movie.
    private(set) var title: String
    
    /// Release date of the movie.
    private(set) var releaseDate: String
    
    /// File name of the movie poster image.
    private var posterImage: String
    
    /// A closure property representing an action to be executed when a movie is selected.
    private (set) var selcteMovieAction: (()->Void)?
    
    
    // MARK: Initialization
    
    /// Initializes a new instance of the MovieCellViewModel.
    ///
    /// - Parameters:
    ///   - title: The title of the movie.
    ///   - releaseDate: The release date of the movie.
    ///   - posterImage: The file name of the movie poster image.
    init(title: String?, releaseDate: String?, posterImage: String?, selcteMovieAction: (()->Void)?) {
        self.title = title ?? ""
        self.releaseDate = releaseDate ?? ""
        self.posterImage = posterImage ?? ""
        self.selcteMovieAction = selcteMovieAction
    }
    
}
