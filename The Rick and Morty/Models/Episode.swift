//
//  Episode.swift
//  The Rick and Morty
//
//  Created by Тимур Ахметов on 01.08.2022.
//

import Foundation

struct PagedEpisode: Codable {
    let info: Info
    let results: [Episode]
}

// MARK: - Episode
struct Episode: Codable {
    let id: Int
    let name: String
    let air_date: String
    let episode: String
    let characters: [String]
    let url: String
}
