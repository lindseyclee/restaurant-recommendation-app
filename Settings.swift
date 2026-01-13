//
//  Settings.swift
//  RestaurantApp
//
//  Created by Lindsey Lee on 5/16/25.
//

import SwiftUI

// view allows users to adjust app preferences: dark mode
// provides information about the app

struct Settings: View {
    @State private var isDarkMode = false // track whether Dark Mode is enabled
   
    var body: some View {
        NavigationView {
            Form {
                // Appearance Section - for accessibility
                Section(header: Text("Appearance")) {
                    // toggle to turn dark mode on/off
                    Toggle(isOn: $isDarkMode) {
                        Label("Dark Mode", systemImage: "moon.fill")
                    }
                }
                // About Section - explain key info/instructions
                Section(header: Text("About")) {
                    Label("Version 1.0", systemImage: "info.circle")
                    Label("Built by: Lindsey Lee", systemImage: "person")
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("GrubGuide helps you discover restaurants, get catered recommendations, and save your favorites—all in one place.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Text("Use simple gestures like swipe and double tap to favorite and unfavorite a spot, and explore with smart filters.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .navigationTitle("Settings")
            
            // applys the preferred color scheme (light/dark) based on toggle - referenced a video tutorial for guidance (readme)
            .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}

#Preview {
    Settings()
}
