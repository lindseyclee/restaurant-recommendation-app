//
//  FavoritesManager.swift
//  RestaurantApp
//
//  Created by Lindsey Lee on 5/23/25.
//

import Foundation

// a class to manage the user's list of favorited restaurants
// ObservableObject - allows views to get any changes

class FavoritesManager: ObservableObject {
    // list to store restaurants user has favorited
    // any views observing will get the update
    @Published var favorites: [Restaurant] = []
    
    // adds a restaurant to the favorites list if not already in the list
    // passes in a restaurant object
    func add(_ restaurant: Restaurant) {
        if !favorites.contains(restaurant) {
            favorites.append(restaurant)
        }
    }
    
    // removes a restaurant to the favorites list
    // passes in a restaurant object
    func remove(_ restaurant: Restaurant) {
        favorites.removeAll { $0 == restaurant }
    }
    
    // checks if a restaurant is in the favorites list already - returns true/false
    // passes in a restaurant object
    func isFavorite(_ restaurant: Restaurant) -> Bool {
        favorites.contains(restaurant)
    }
}
