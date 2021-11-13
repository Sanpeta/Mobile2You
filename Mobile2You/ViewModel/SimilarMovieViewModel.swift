//
//  SimilarMovieViewModel.swift
//  Mobile2You
//
//  Created by Sidnei de Souza Junior on 24/09/21.
//

import Foundation

//MARK: - Similar Movie List
struct SimilarMovieListViewModel {
    private let similarMovieList: SimilarMovieList
    
    init(similarMovieList: SimilarMovieList) {
        self.similarMovieList = similarMovieList
    }
}

extension SimilarMovieListViewModel {
    var numberOfSection: Int {
        return 1
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return self.similarMovieList.results.count
    }
    
    func similarMovieAtIndex(_ index: Int) -> SimilarMovieViewModel {
        let movie = self.similarMovieList.results[index]
        return SimilarMovieViewModel(similarMovie: movie)
    }
}


//MARK: - Similar Movie
struct SimilarMovieViewModel {
    private let similarMovie: SimilarMovie
    
    init(similarMovie: SimilarMovie) {
        self.similarMovie = similarMovie
    }
}

extension SimilarMovieViewModel {
    var title: String {
        return similarMovie.title
    }
    
    var poster_path: String {
        return similarMovie.poster_path ?? ""
    }
    
    var release_date: String {
        let year = similarMovie.release_date.split(separator: "-")
        return String(year[0])
    }
    
    var genre_ids: [Int] {
        return similarMovie.genre_ids
    }
}
