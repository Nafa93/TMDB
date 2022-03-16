//
//  NowPlayingMovies.swift
//  TMDB (iOS)
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 15/03/2022.
//

import Foundation

struct NowPlayingResponse: Codable {
    var results: [Movie]
}
