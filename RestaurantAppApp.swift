//
//  RestaurantAppApp.swift
//  RestaurantApp
//
//  Created by Lindsey Lee on 5/16/25.
//

import SwiftUI

// app main
// sets up shared environment

@main
struct RestaurantAppApp: App {
    @StateObject var favoritesManager = FavoritesManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(favoritesManager) // inject environment object for testing across all views
        }
    }
}
