//
//  ContentView.swift
//  RestaurantApp
//
//  Created by Lindsey Lee on 5/16/25.
//

import SwiftUI

// organizes the app's tab based navigation
// uses tab view to allow navigating between 4 different views/pages
//

struct ContentView: View {
    @State var selection = 1 // tracks which tab is selected
    @State var foregroundColor: Color = .blue
    @State var backgroundColor: Color = .white
    @EnvironmentObject var favoritesManager: FavoritesManager // shared environment state across view files for managing favorited restaurants
 
    var body: some View {
        TabView (selection: $selection) {
            // tab view 1 - Home Tab
            HomeScreen()
                .tabItem {
                    Image(systemName: "house.circle.fill")
                    Text("Home")
                }
                // add to control current tab
                .tag(1)
            
            // tab view 2 - Explore Tab
            ExploreRestaurants()
                .tabItem {
                    Image(systemName: "magnifyingglass.circle.fill")
                    Text("Explore")
                }
                // add to control current tab
                .tag(2)
            
            // tab view 3 - Favorites Tab
            FavoritesView()
                .tabItem {
                    Image(systemName: "heart.circle.fill")
                    Text("Favorites")
                }
                // add to control current tab
                .tag(3)
            
            // tab view 4 - Settings Tab
            Settings()
                .tabItem {
                    Image(systemName: "gearshape.circle.fill")
                    Text("Settings")
                }
                // add to control current tab
                .tag(4)
           
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(FavoritesManager()) // inject environment object for testing across all views
}
