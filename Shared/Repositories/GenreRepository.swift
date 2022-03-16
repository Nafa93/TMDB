//
//  GenreRepository.swift
//  TMDB (iOS)
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 15/03/2022.
//

import Foundation

struct GenreRepository {
    func fetchGenres() async throws -> [Genre] {
        let requestConfiguration = GenresRequestConfiguration()
        let response: GenresResponse = try await ServiceLayer.request(configuration: requestConfiguration)
        return response.genres
    }
}
