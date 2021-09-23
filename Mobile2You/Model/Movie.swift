//
//  Movie.swift
//  Mobile2You
//
//  Created by Sidnei de Souza Junior on 22/09/21.
//

import Foundation

struct Movie: Codable {
    let title: String
    let vote_count: Int
    let popularity: Double
    let response: String
}
