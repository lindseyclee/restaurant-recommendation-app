//
//  ExploreRestaurants.swift
//  RestaurantApp
//
//  Created by Lindsey Lee on 5/16/25.
//

import SwiftUI

// view to Explore all Restaurants in the database from around the world
// includes name, cuisines, city, rating, & price range details
// users can use the search bar to filter down results

struct ExploreRestaurants: View {
    @State private var searchText = "" // user input for search bar
    @State private var showRecommended = false
    
    @EnvironmentObject var favoritesManager: FavoritesManager // access to shared FavoritesManager object across all views
    
    // returns a list of restaurants filtered by search text
    var filteredRestaurants: [Restaurant] {
        var fullList = restaurantData // all data
        
        // filter if only showing recommended
        if showRecommended {
            fullList = fullList.filter { $0.isRecommended }
        }
        
        // filter by search text across name, city, or cuisine
        if !searchText.isEmpty {
            fullList = fullList.filter {
                $0.restaurantName.localizedCaseInsensitiveContains(searchText) ||
                $0.city.localizedCaseInsensitiveContains(searchText) ||
                $0.cuisines.localizedCaseInsensitiveContains(searchText)
            }
        }
        return fullList
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    // if on, it will show only recommended restaurants based on isRecommended = true
                    Toggle("Show Recommended Only", isOn: $showRecommended)
                        .padding(.horizontal)
                }
                
                // trace through each restaurant in the list of restaurant data and display each with details
                ForEach(filteredRestaurants) { restaurant in
                    HStack {
                        VStack(alignment: .leading) {
                            // display restaurant name
                            Text(restaurant.restaurantName)
                                .font(.headline)
                            // display all cuisines offered
                            Text("\(restaurant.cuisines)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            // display city location
                            Text("\(restaurant.city)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            // display rating (1-4) and price range ($-$$$$)
                            Text("⭐️ \(String(format: "%.1f", restaurant.rating))  💰 \(convertPriceRange( restaurant.priceRange))")
                                .font(.footnote)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                        
                        // display empty heart icon
                        // implement gesture: double-tap to fill heart icon and add to favorites list
                        Image(systemName: favoritesManager.isFavorite(restaurant) ? "heart.fill" : "heart")
                            .foregroundColor(.red)
                            .onTapGesture(count: 2) {
                                // removes restaurant from favorites on gesture if already in the list
                                if favoritesManager.isFavorite(restaurant) {
                                    favoritesManager.remove(restaurant)
                                } else {
                                    // otherwise adds restaurant to favorites list
                                    favoritesManager.add(restaurant)
                                }
                            }
                    }
                    .padding(.vertical, 5)
                }
            }
            .navigationTitle("Explore Restaurants")
            .searchable(text: $searchText) // create search bar
        } // end navigation stack
    }
    
    // function to convert the priceRange of 1-4 to $-$$$$
    func convertPriceRange(_ priceRange: Int) -> String {
        return String(repeating: "$", count: priceRange)
        
    }// end var body
}

#Preview {
    ExploreRestaurants()
        .environmentObject(FavoritesManager()) // inject environment object for testing across all views
}
