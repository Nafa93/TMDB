//
//  FavoritesView.swift
//  TMDB (iOS)
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 15/03/2022.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var favoriteStore: FavoriteStore
    
    var gridItems: [GridItem] {
        Array(repeating: GridItem(.flexible()), count: 2)
    }
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVGrid(columns: gridItems, spacing: 16) {
                ForEach(favoriteStore.favoriteMovies) { movie in
                    MovieCard(movie: movie)
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(16)
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
