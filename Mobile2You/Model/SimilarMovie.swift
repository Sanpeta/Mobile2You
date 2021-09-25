//
//  SimilarMovie.swift
//  Mobile2You
//
//  Created by Sidnei de Souza Junior on 24/09/21.
//

import Foundation

struct Similar: Codable {
    let page: Int
    let results: [SimilarMovie]
}

struct SimilarMovie: Codable {
    let title: String
    let poster_path: String?
    let release_date: String
    let genre_ids: [Int]
}
