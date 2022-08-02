//
//  Location.swift
//  The Rick and Morty
//
//  Created by Тимур Ахметов on 01.08.2022.
//

import Foundation

struct PagedLocation: Codable {
    let info: Info
    let results: [Location]
}

// MARK: - Location
struct Location: Codable {
    let id: Int
    let name: String
    let type: String
    let dimension: String
    let residents: [String]
    let url: String
}
