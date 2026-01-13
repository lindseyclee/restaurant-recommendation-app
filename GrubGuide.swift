//
//  GrubGuide.swift
//  RestaurantApp
//
//  Created by Lindsey Lee on 5/21/25.
//

import SwiftUI

// the main view where users can input their restaurant preferences to get matched recommendations based on a dataset of restaurants


struct GrubGuide: View {
    @State private var selectedCity = ""
    @State private var selectedCuisine = ""
    @State private var rating: Double = 4.0
    @State private var priceRange: Int = 2
    @State private var hasOnlineDelivery = false
    @State private var hasTableBooking = false
    
    @State private var recommendations: [Restaurant] = [] // stores a list of recommended restaurants if matched
    @EnvironmentObject var favoritesManager: FavoritesManager // access to shared FavoritesManager object across all views
        
    var body: some View {
        NavigationStack {
            Form {
                // Your Preferences Section
                Section(header: Text("Your Preferences")) {
                    // user selects a city they are looking for from the dataset
                    Picker("🏙️ City", selection: $selectedCity) {
                        ForEach(Array(Set(restaurantData.map { $0.city })).sorted(), id: \.self) { city in
                            Text(city).tag(city)
                        }
                    }
                    
                    // user types the types of cuisines they want in a text field (right now it shows every unique value from the data)
                    Picker("🍴 Cuisine", selection: $selectedCuisine) {
                        ForEach(Array(Set(restaurantData.map { $0.cuisines })).sorted(), id: \.self) { cuisine in
                            Text(cuisine).tag(cuisine)
                        }
                    }
                    
                    // user selects the rating they are looking for (0-5) incrementing/decrementing by 1
                    Stepper(value: $rating, in: 0...5, step: 0.1) {
                        Text("⭐️ Rating: \(rating, specifier: "%.1f")+")
                    }
                    
                    
                    // user selects the price range they want ($-$$$$)
                    Picker("💲 Price Range", selection: $priceRange) {
                        ForEach(1...4, id: \.self) { i in
                            Text(String(repeating: "$", count: i)).tag(i)
                        }
                    }
                    
                    // user can specify if they want online delivery available
                    Toggle("🚗 Has Online Delivery", isOn: $hasOnlineDelivery)
                    
                    // user can specify if they want table booking/reservations available
                    Toggle("📞 Has Table Booking", isOn: $hasTableBooking)
                }
                
                // Button to call getRecommendation() to generate results
                Section(header: Text("Find Restaurants")) {
                    Button("Get Recommendation") {
                        // filter and update recommendations based on user input
                        recommendations = getRecommendedRestaurants(
                            from: restaurantData,
                            city: selectedCity,
                            cuisines: selectedCuisine,
                            hasTableBooking: hasTableBooking,
                            hasOnlineDelivery: hasOnlineDelivery,
                            priceRange: priceRange,
                            minRating: rating
                        )
                    }
                }
                
                // Recommended Restaurants Section - results
                if !recommendations.isEmpty {
                    Section(header: Text("Recommended Restaurant(s)")) {
                        // displays each restaurant from the list if there are any matches
                        ForEach(recommendations) { restaurant in
                            HStack {
                                Text(restaurant.restaurantName)
                                Spacer()
                                // allow user to favorite the restaurant
                                Image(systemName: favoritesManager.isFavorite(restaurant) ? "heart.fill" : "heart")
                                    .foregroundColor(.red)
                                    // implement gesture: double-tap to favorite the restaurant, fill icon
                                    .onTapGesture(count: 2) {
                                        // if already favorited, then unfavorite by the gesture
                                        if favoritesManager.isFavorite(restaurant) {
                                            favoritesManager.remove(restaurant)
                                        } else {
                                            favoritesManager.add(restaurant)
                                        }
                                    }
                            }
                            
                        }
                    }
                } else {
                    // if there were no matches/the list was empty, display a message to notify the user
                    Section(header: Text("Recommended Restaurant(s)")) {
                        Text("No matches found. Try adjusting your preferences.")
                            .foregroundColor(.gray)
                    }
                }
                
               
            }
            .navigationTitle("🍽️ GrubGuide")
        } // end navigation stack
    }
    
    // returns a restaurant matched based on comparing against user input to filter the result
    func getRecommendedRestaurants(from restaurants: [Restaurant], city: String, cuisines: String, hasTableBooking: Bool, hasOnlineDelivery: Bool, priceRange: Int, minRating: Double) -> [Restaurant] {
        return restaurants.filter { restaurant in
            restaurant.city == city &&
            restaurant.cuisines.contains(cuisines) &&
            restaurant.hasTableBooking == hasTableBooking &&
            restaurant.hasOnlineDelivery == hasOnlineDelivery &&
            restaurant.priceRange == priceRange &&
            restaurant.rating >= minRating
        }
    }
    
}

#Preview {
    GrubGuide()
        .environmentObject(FavoritesManager()) // inject environment object for testing across all views
}
