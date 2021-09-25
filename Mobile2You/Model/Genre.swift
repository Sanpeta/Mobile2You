//
//  Genre.swift
//  Mobile2You
//
//  Created by Sidnei de Souza Junior on 25/09/21.
//

import Foundation

struct Genres: Codable {
    let genres: [Genre]
}

struct Genre: Codable {
    let id: Int
    let name: String
}
