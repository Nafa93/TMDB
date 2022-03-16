//
//  Genres.swift
//  TMDB (iOS)
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 15/03/2022.
//

import Foundation

struct GenresResponse: Codable {
    var genres: [Genre]
}

struct Genre: Codable, Identifiable {
    var id: Int
    var name: String
}
