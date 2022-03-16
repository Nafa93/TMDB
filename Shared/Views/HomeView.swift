//
//  ContentView.swift
//  Shared
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 15/03/2022.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel
    @EnvironmentObject var favoriteStore: FavoriteStore
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(viewModel.genres) { genre in
                            Button {
                                viewModel.onGenreTap(genre)
                            } label: {
                                Text(genre.name)
                                    .padding(8)
                                    .background(
                                        genreChipColor(genre)
                                    )
                                    .cornerRadius(10)
                            }
                        }
                        .redacted(reason: viewModel.isLoadingGenres ? [.placeholder] : [])
                    }
                    .padding(.horizontal, 16)
                }
                
                HStack {
                    
                    Button {
                        viewModel.toggleVoteSortingType()
                    } label: {
                        HStack {
                            Text(voteSortingTypeText)
                            
                            if !voteSortingTypeImageName.isEmpty {
                                Image(systemName: voteSortingTypeImageName)
                                    .resizable()
                                    .frame(width: 16, height: 16)
                            }
                        }
                    }
                    .padding(8)
                    .background(
                        Color.gray.opacity(0.2)
                    )
                    .cornerRadius(10)
                    .foregroundColor(.black)
                    
                    
                    Button {
                        viewModel.toggleDateSortingType()
                    } label: {
                        HStack {
                            Text(dateSortingTypeText)
                            
                            if !dateSortingTypeImageName.isEmpty {
                                Image(systemName: dateSortingTypeImageName)
                                    .resizable()
                                    .frame(width: 16, height: 16)
                            }
                        }
                    }
                    .padding(8)
                    .background(
                        Color.gray.opacity(0.2)
                    )
                    .cornerRadius(10)
                    .foregroundColor(.black)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 16)
                
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVGrid(columns: gridItems, spacing: 16) {
                        ForEach(viewModel.filteredMovies) { movie in
                            TappableMovieCard(movie: movie) { movie in
                                favoriteStore.toggleFavorite(movie)
                            }
                            .frame(maxWidth: .infinity)
                        }
                    }
                    .padding(16)
                }
                .onAppear {
                    viewModel.fetchMovies()
                    viewModel.fetchGenres()
                }
                .animation(.linear(duration: 0.2), value: viewModel.filteredMovies)
            }
            .toolbar {
                NavigationLink("Favorites") {
                    FavoritesView()
                        .environmentObject(favoriteStore)
                }
            }
            .searchable(text: $viewModel.queryString, placement: .navigationBarDrawer(displayMode: .always))
            .onChange(of: viewModel.queryString) { newValue in
                viewModel.filterMovies(with: newValue, byGenreIds: viewModel.selectedGenres)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("TMDB")
        }
    }
    
    var gridItems: [GridItem] {
        Array(repeating: GridItem(.flexible()), count: 2)
    }
    
    var voteSortingTypeText: String {
        switch viewModel.voteSortingType {
        case .ascending:
            return "Vote Ascending"
        case .descending:
            return "Vote Descending"
        case .noOrder:
            return "No Vote Order"
        }
    }
    
    var voteSortingTypeImageName: String {
        switch viewModel.voteSortingType {
        case .ascending:
            return "arrow.up"
        case .descending:
            return "arrow.down"
        case .noOrder:
            return ""
        }
    }
    
    var dateSortingTypeText: String {
        switch viewModel.dateSortingType {
        case .orderedAscending:
            return "Date Ascending"
        case .orderedDescending:
            return "Date Descending"
        case .orderedSame:
            return "No Date Order"
        }
    }
    
    var dateSortingTypeImageName: String {
        switch viewModel.dateSortingType {
        case .orderedAscending:
            return "arrow.up"
        case .orderedDescending:
            return "arrow.down"
        case .orderedSame:
            return ""
        }
    }
    
    func genreChipColor(_ genre: Genre) -> Color {
        viewModel.selectedGenres.contains(genre.id) ? Color.gray.opacity(0.5) : Color.gray.opacity(0.2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var viewModel = HomeViewModel()
    
    static var previews: some View {
        HomeView(viewModel: viewModel)
    }
}
