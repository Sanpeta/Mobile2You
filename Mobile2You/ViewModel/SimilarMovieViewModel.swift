//
//  SimilarMovieViewModel.swift
//  Mobile2You
//
//  Created by Sidnei de Souza Junior on 24/09/21.
//

import Foundation

struct SimilarMovieViewModel {
    let title: String
    let poster_path: String?
    let release_date: String
    let genre_ids: [Int]
    
    init(similarMovie: SimilarMovie) {
        self.title = similarMovie.title
        self.poster_path = similarMovie.poster_path
        let year = similarMovie.release_date.split(separator: "-")
        self.release_date = String(year[0])
        self.genre_ids = similarMovie.genre_ids
    }
}
