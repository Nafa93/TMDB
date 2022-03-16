//
//  MovieRepository.swift
//  TMDB (iOS)
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 15/03/2022.
//

import Foundation

struct MovieRepository {
    func fetchMovies() async throws -> [Movie] {
        let requestConfiguration = NowPlayingRequestConfiguration()
        let response: NowPlayingResponse = try await ServiceLayer.request(configuration: requestConfiguration)
        return response.results
    }
}
