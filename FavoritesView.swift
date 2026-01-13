//
//  Favorites.swift
//  RestaurantApp
//
//  Created by Lindsey Lee on 5/16/25.
//

import SwiftUI

// view to display the list of current favorited restaurants
// allows user to easily and efficiently view & remove restaurants from their favorites

struct FavoritesView: View {
    @EnvironmentObject var favoritesManager: FavoritesManager // access to shared FavoritesManager object across all views
    
    var body: some View {
        NavigationStack {
            Form {
                // if favorites list is empty, display a message to indicate so
                if favoritesManager.favorites.isEmpty {
                    Text("No favorites yet! 💔")
                        .foregroundColor(.gray)
                } else {
                    // display each restaurant in the favorites list
                    ForEach(favoritesManager.favorites) { restaurant in
                        HStack {
                            // show restaurant name
                            Text(restaurant.restaurantName)
                            Spacer()
                            // display heart icon along the right side of each item based on if favorited or not
                            Image(systemName: favoritesManager.isFavorite(restaurant) ? "heart.fill" : "heart")
                                .foregroundColor(.red)
                                // implement gesture: double-tap to unlike an item
                                .onTapGesture(count: 2) {
                                    if favoritesManager.isFavorite(restaurant) {
                                        favoritesManager.remove(restaurant)
                                    } else {
                                        favoritesManager.add(restaurant)
                                    }
                                }
                        }
                    }
                }
            }
            .navigationTitle("Favorites")
        }
    }
}

#Preview {
    FavoritesView()
        .environmentObject(FavoritesManager()) // inject environment object for testing across all views
}
