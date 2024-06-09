//
//  MovieObject.swift
//  TMDbMovies
//
//  Created by ELKHADRAGI Moamen on 06/06/2024.
//

import CoreData

@objc(MovieObject)
final class MovieObject: NSManagedObject {
    @NSManaged var listType: String
    @NSManaged var id: String
    @NSManaged var title: String?
    @NSManaged var poster: String?
    @NSManaged var releaseDate: String?
}

extension MovieObject: ToEntity {

    func toEntity() -> MovieEntity {
        return MovieEntity(id: Int(id), title: title, poster: poster, releaseDate: releaseDate)
    }
}

