//
//  TMDBApp.swift
//  Shared
//
//  Created by Nicolas Alejandro Fernandez Amorosino on 15/03/2022.
//

import SwiftUI

@main
struct TMDBApp: App {
    @State var homeViewModel = HomeViewModel()
    @State var favoriteStore = FavoriteStore()
    
    
    var body: some Scene {
        WindowGroup {
            HomeView(viewModel: homeViewModel)
                .tabItem {
                    Label("Home", systemImage: "list.dash")
                }
                .environmentObject(favoriteStore)
        }
    }
}
