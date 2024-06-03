//
//  Samples.swift
//  AppServicesTests
//
//  Created by ELKHADRAGI Moamen on 04/06/2024.
//

import Foundation

struct Samples: Codable {
    let samples: [Sample]
}

struct Sample: Codable {
    let id: Int
}
