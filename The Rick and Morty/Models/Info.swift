//
//  Info.swift
//  The Rick and Morty
//
//  Created by Тимур Ахметов on 01.08.2022.
//

import Foundation

struct Info: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}
