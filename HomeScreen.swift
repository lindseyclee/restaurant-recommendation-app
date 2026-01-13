//
//  HomeScreen.swift
//  RestaurantApp
//
//  Created by Lindsey Lee on 5/16/25.
//

import SwiftUI

// display Home Screen (title page)
// first page user sees when they open the app
// a navigation link directs the user into the main app leading to GrubGuide view

struct HomeScreen: View {
    @EnvironmentObject var favoritesManager: FavoritesManager // access to shared FavoritesManager object across all views
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 40) {
                // style title page: display app name
                Text("🍽️ GrubGuide")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.pink)
                
                // display welcome message to the app
                Text("Find the perfect restaurant for your next meal!")
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                // navigation link - takes user to GrubGuide() view to get started/continue on in the app
                NavigationLink(destination: GrubGuide()) {
                    Text("Let’s Get Started")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.pink)
                        .foregroundColor(.white)
                        .cornerRadius(30)
                        .padding(.horizontal)
                }
            }
            .padding()
        } // end navigation stack
    }
}

#Preview {
    HomeScreen()
}
