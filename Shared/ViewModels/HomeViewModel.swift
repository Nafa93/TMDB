//
//  HomeViewModel.swift
//  TMDB (iOS)
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 15/03/2022.
//

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var filteredMovies: [Movie] = []
    @Published var genres: [Genre] = []
    @Published var selectedGenres = Set<Int>()
    @Published var queryString = ""
    @Published var isLoadingGenres = false
    @Published var voteSortingType: SortingType = .noOrder
    @Published var dateSortingType: ComparisonResult = .orderedSame
    
    private var movieRepository = MovieRepository()
    private var genreRepository = GenreRepository()
    
    func fetchMovies() {
        Task {
            do {
                let newMovies = try await movieRepository.fetchMovies()
                
                DispatchQueue.main.async {
                    self.movies = newMovies
                    self.filteredMovies = newMovies
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func filterMovies(with queryString: String, byGenreIds: Set<Int>) {
        DispatchQueue.main.async {
            if queryString.isEmpty {
                self.filteredMovies = self.movies.filter {
                    self.selectedGenres.isSubset(of: $0.genreIds)
                }
            } else {
                self.filteredMovies = self.movies.filter {
                    $0.title.lowercased().contains(queryString.lowercased()) &&
                    self.selectedGenres.isSubset(of: $0.genreIds)
                }
            }
        }
    }
    
    func fetchGenres() {
        self.isLoadingGenres = true
        
        Task {
            let newGenres = try await genreRepository.fetchGenres()
            
            DispatchQueue.main.async {
                self.genres = newGenres
                self.isLoadingGenres = false
            }
        }
    }
    
    func onGenreTap(_ genre: Genre) {
        toggleGenre(genre)
        filterMovies(with: queryString, byGenreIds: selectedGenres)
    }
    
    func toggleGenre(_ genre: Genre) {
        DispatchQueue.main.async {
            if self.selectedGenres.contains(genre.id) {
                self.selectedGenres.remove(genre.id)
            } else {
                self.selectedGenres.insert(genre.id)
            }
        }
    }
    
    func filterMovies(by genres: Set<Int>) {
        DispatchQueue.main.async {
            self.filteredMovies = self.movies.filter {
                genres.isSubset(of: $0.genreIds)
            }
            
            self.sortMovies(dateOrder: self.dateSortingType)
            self.sortMovies(voteOrder: self.voteSortingType)
        }
    }
    
    func toggleVoteSortingType() {
        DispatchQueue.main.async {
            self.dateSortingType = .orderedSame
            
            switch self.voteSortingType {
            case .ascending:
                self.voteSortingType = .descending
            case .descending:
                self.voteSortingType = .noOrder
            case .noOrder:
                self.voteSortingType = .ascending
            }
            
            self.sortMovies(voteOrder: self.voteSortingType)
        }
    }
    
    func toggleDateSortingType() {
        DispatchQueue.main.async {
            self.voteSortingType = .noOrder
            
            switch self.dateSortingType {
            case .orderedAscending:
                self.dateSortingType = .orderedDescending
            case .orderedDescending:
                self.dateSortingType = .orderedSame
            case .orderedSame:
                self.dateSortingType = .orderedAscending
            }
            
            self.sortMovies(dateOrder: self.dateSortingType)
        }
    }
    
    func sortMovies(voteOrder: SortingType) {
        guard voteOrder != .noOrder else {
            DispatchQueue.main.async {
                self.filteredMovies = self.movies
                self.filterMovies(with: self.queryString, byGenreIds: self.selectedGenres)
            }
            
            return
        }
        
        self.filteredMovies = self.filteredMovies.sorted(by: {
            self.voteSortingType.validate(firstVote: $0.voteAverage, secondVote: $1.voteAverage)
        })
    }
    
    func sortMovies(dateOrder: ComparisonResult) {
        guard dateOrder != .orderedSame else {
            DispatchQueue.main.async {
                self.filteredMovies = self.movies
                self.filterMovies(with: self.queryString, byGenreIds: self.selectedGenres)
            }
            
            return
        }
        
        self.filteredMovies = self.filteredMovies.sorted(by: {
            guard let firstDate = $0.releaseDate, let secondDate = $1.releaseDate else {
                return false
            }
            
            return firstDate.compare(secondDate) == self.dateSortingType
        })
    }
}
