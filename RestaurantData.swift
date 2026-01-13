//
//  RestaurantData.swift
//  RestaurantApp
//
//  Created by Lindsey Lee on 5/22/25.
//

import Foundation

import UIKit
import SwiftUI

// load the json file for the restaurant dataset here
// code taken from Cars class demo
var restaurantData: [Restaurant] = loadJson("restaurantData.json")

func loadJson<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename,
                                     withExtension: nil)
    else {
        fatalError("\(filename) not found.")
    }
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Could not load \(filename): \(error)")
    }
    do {
        return try JSONDecoder().decode(T.self, from: data)
    } catch {
        fatalError("Unable to parse \(filename): \(error)")
    }
}
