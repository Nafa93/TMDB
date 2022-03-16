//
//  Movie.swift
//  TMDB (iOS)
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 15/03/2022.
//

import Foundation

struct Movie: Codable, Identifiable {
    var id: Int
    var title: String
    var posterPath: String
    var genreIds: Set<Int>
    var voteAverage: Float
    var releaseDateString: String
    
    var releaseDate: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "YYYY-MM-DD"
        return dateFormatter.date(from: releaseDateString)
    }
    
    var formattedAverage: String {
        String(format: "%.2f", voteAverage)
    }
    
    enum CodingKeys: String, CodingKey {
        case id, title, posterPath, genreIds, voteAverage, releaseDateString = "releaseDate"
    }
}

extension Movie: Hashable, Equatable {
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension Movie {
    func getPosterUrl(movie: Movie) -> URL? {
        let requestConfiguration = PosterRequestConfiguration(posterPath: movie.posterPath)
        
        return ServiceLayer.getUrl(from: requestConfiguration)
    }
}
