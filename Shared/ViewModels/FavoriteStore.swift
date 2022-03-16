//
//  FavoritesStore.swift
//  TMDB (iOS)
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 15/03/2022.
//

import Combine

class FavoriteStore: ObservableObject {
    @Published private(set) var favoriteMovies: [Movie] = []
    
    func toggleFavorite(_ movie: Movie) {
        guard let movieIndex = favoriteMovies.firstIndex(where: { $0.id == movie.id }) else {
            favoriteMovies.append(movie)
            return
        }
        
        favoriteMovies.remove(at: movieIndex)
    }
}
