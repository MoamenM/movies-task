//
//  ToEntity.swift
//  TMDbMovies
//
//  Created by ELKHADRAGI Moamen on 09/06/2024.
//

import Foundation

protocol ToEntity {
    associatedtype Entity
    
    func toEntity() -> Entity
}
