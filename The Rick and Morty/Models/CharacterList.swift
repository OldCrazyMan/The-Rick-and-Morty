//
//  Character.swift
//  The Rick and Morty
//
//  Created by Тимур Ахметов on 01.08.2022.
//

import Foundation

// MARK: - Character
struct CharacterList: Codable {
    let info: Info
    let results: [Character]
}

// MARK: - Character
struct Character: Codable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let gender: String
    let location: CharacterLocation
    let image: String
    let origin: Origin
    let episode: [String]?
}

// MARK: - CharacterLocation
struct CharacterLocation: Codable {
    let name: String
}

//MARK: - Origin
struct Origin: Codable {
    let name: String
    let url: String
}
