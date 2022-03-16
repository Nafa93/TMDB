//
//  MovieCard.swift
//  TMDB (iOS)
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 15/03/2022.
//

import SwiftUI

struct TappableMovieCard: View {
    var movie: Movie
    
    var onStarTap: (Movie) -> Void
    
    @State private var selected = false
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            MovieCard(movie: movie)

            Button {
                selected.toggle()
                onStarTap(movie)
            } label: {
                Image(systemName: selected ? "star.fill" : "star")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.yellow)
                    .padding(8)
            }
        }
    }
}

struct TappableMovieCard_Previews: PreviewProvider {
    static var previews: some View {
        TappableMovieCard(movie: Movie(id: 0,
                                       title: "The Batman",
                                       posterPath: "s",
                                       genreIds: [1],
                                       voteAverage: 1.0,
                                       releaseDateString: "")) { movie in
            print(movie)
        }
    }
}
