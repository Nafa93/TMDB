//
//  MovieCard.swift
//  TMDB (iOS)
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 15/03/2022.
//

import SwiftUI


struct MovieCard: View {
    var movie: Movie
    
    var body: some View {
        ZStack(alignment: .bottom) {
            LinearGradient(colors: [.black.opacity(0.3), .black.opacity(0.1), .black.opacity(0.7)],
                           startPoint: .top,
                           endPoint: .bottom)
                .zIndex(1)
                .cornerRadius(10)
            
            AsyncImage(url: movie.getPosterUrl(movie: movie)) { phase in
                if let image = phase.image {
                    image
                        .interpolation(.none)
                        .resizable()
                        .frame(maxWidth: .infinity)
                        .cornerRadius(10)
                } else if phase.error != nil {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .resizable()
                        .frame(width: 90, height: 90, alignment: .center)
                        .foregroundColor(.red)
                } else {
                    ProgressView()
                        .progressViewStyle(
                            CircularProgressViewStyle(tint: Color.black)
                        )
                }
            }
            .frame(height: 250)
            
            VStack(spacing: 8) {
                Text(movie.title)
                    .font(.title3)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("Release Date: \(movie.releaseDateString)")
                    .font(.caption)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("Rating: \(movie.formattedAverage)/10")
                    .font(.caption)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(8)
            .foregroundColor(.white)
            .zIndex(2)
            .background(.black.opacity(0.6))
            .cornerRadius(10, corners: [.bottomLeft, .bottomRight])
        }

    }
}

struct MovieCard_Previews: PreviewProvider {
    static var previews: some View {
        MovieCard(movie: Movie(id: 0,
                               title: "The Batman",
                               posterPath: "s",
                               genreIds: [1],
                               voteAverage: 1.0,
                               releaseDateString: ""))
    }
}
