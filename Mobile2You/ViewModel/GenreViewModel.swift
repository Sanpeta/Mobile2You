//
//  GenreViewModel.swift
//  Mobile2You
//
//  Created by Sidnei de Souza Junior on 25/09/21.
//

import Foundation

struct GenreViewModel {
    let id: Int
    let name: String
    
    init(genre: Genre) {
        self.id = genre.id
        self.name = genre.name
    }
}
