//
//  Restaurant.swift
//  RestaurantApp
//
//  Created by Lindsey Lee on 5/22/25.
//

import Foundation

// a data model representing a Restaurant and its key attributes

struct Restaurant: Hashable, Codable, Identifiable {
    let id: Int // unique identifier
    let restaurantName: String // name of restaurant
    let city: String // where restaurant is located
    let cuisines: String // type of cuisines offered by the restaurant
    let hasTableBooking: Bool // indicates if restaurant accepts table bookings
    let hasOnlineDelivery: Bool // indicates if restaurant offers online delivery
    let priceRange: Int // range of the price level of the restaurant's menu items (1-4)
    let rating: Double // average rating of the restaurant based on customer reviews (0-4.9)
    let isRecommended: Bool // custom variable: indicates if restaurant is recommended (rating > 4.2)
}
