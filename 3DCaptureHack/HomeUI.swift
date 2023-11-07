//
//  HomeUI.swift
//  3DCaptureHack
//
//  Created by Raphael Fassotte on 07/11/2023.
//

import SwiftUI

struct HomeUI: View {
    
    var body: some View {
        TabView {
            // Premier onglet avec ListView
            NavigationView {
                ListView()
                    .navigationTitle("Home")
            }
            .tabItem {
                Label("Home", systemImage: "house.fill")
            }

            // Deuxième onglet
            NavigationView {
                VStack {
                    Text("Contenu du deuxième onglet")
                        .font(.largeTitle)
                        .padding()
                }
                .navigationTitle("Captur")
            }
            .tabItem {
                Label("Captur", systemImage: "camera.fill")
            }
        }
    }
}

struct ListView: View {
    var body: some View {
        List {
            ForEach(0..<10) { index in
                Text("item \(index)")
            }
        }
    }
}

#Preview {
    HomeUI()
}
