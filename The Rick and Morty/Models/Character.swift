//
//  Character.swift
//  The Rick and Morty
//
//  Created by Тимур Ахметов on 01.08.2022.
//

import Foundation

// MARK: - Character
struct Character: Codable {
    let info: Info
    let results: [Result]
}

// MARK: - Result
struct Result: Codable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let gender: String
    let location: LocationChar
    let image: String
    let episode: [String]?
}

// MARK: - LocationChar
struct LocationChar: Codable {
    let name: String
}
