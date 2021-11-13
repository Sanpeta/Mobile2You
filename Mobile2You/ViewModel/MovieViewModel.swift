//
//  MovieViewModel.swift
//  Mobile2You
//
//  Created by Sidnei de Souza Junior on 24/09/21.
//

import Foundation
import UIKit

struct MovieViewModel {
    private let movie: Movie

    init(_ movie: Movie) {
        self.movie = movie
    }
}

//MARK: - Extension
extension MovieViewModel {
    //MARK: - Title
    var title: String {
        return self.movie.title
    }
    
    //MARK: - Vote_Count
    var vote_count: String {
        if (self.movie.vote_count == 0 || self.movie.vote_count == 1) {
            return "\(movie.vote_count) Like"
        } else if self.movie.vote_count > 1000 { // MIL
            let convertToK = Double(self.movie.vote_count / 1000)
            return "\(String(format: "%.1f", convertToK))K Likes"
        } else if self.movie.vote_count > 1000000 { // MILHOES
            let convertToK = Double(self.movie.vote_count / 1000000)
            return "\(String(format: "%.1f", convertToK))M Likes"
        } else {
            return "\(self.movie.vote_count) Likes"
        }
    }
    
    //MARK: - Popularity
    var popularity: String {
        if (self.movie.popularity == 0 || self.movie.popularity == 1) {
            return "\(self.movie.popularity) view"
        } else {
            return "\(self.movie.popularity) views"
        }
    }
    
    //MARK: - Backdrop_Path
    var backdrop_path: String {
        return self.movie.backdrop_path
    }
}
