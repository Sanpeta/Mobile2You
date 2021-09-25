//
//  MovieViewModel.swift
//  Mobile2You
//
//  Created by Sidnei de Souza Junior on 24/09/21.
//

import Foundation
import UIKit

struct MovieViewModel {    
    let title: String
    let vote_count: String
    let popularity: String
    let backdrop_path: String
    
    //Dependency Injection
    init(movie: Movie) {
        self.title = movie.title
        if movie.vote_count > 1000 {
            let convertToK = Double(movie.vote_count / 1000)
            self.vote_count = "\(String(format: "%.1f", convertToK))K Likes"
        } else {
            self.vote_count = "\(movie.vote_count) Likes"
        }
        self.popularity = "\(movie.popularity) views"
        self.backdrop_path = movie.backdrop_path
    }
    
}
