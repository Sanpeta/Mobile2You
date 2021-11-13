//
//  GenreViewModel.swift
//  Mobile2You
//
//  Created by Sidnei de Souza Junior on 25/09/21.
//

import Foundation

struct GenresViewModel {
    private let genres: Genres
    
    init(_ genres: Genres) {
        self.genres = genres
    }
}

struct GenreViewModel {
    private let genre: Genre

    init(genre: Genre) {
        self.genre = genre
    }
    
    var id: Int {
        return self.genre.id
    }
    
    var name: String {
        return self.genre.name
    }
}
