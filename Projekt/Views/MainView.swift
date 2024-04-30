//
//  ContentView.swift
//  Projekt
//
//  Created by Milan Tóth on 23.04.24.
//

import SwiftUI
import SwiftData

struct MainView: View {
    
    let modelContainer: ModelContainer
        
        init() {
            do {
                modelContainer = try ModelContainer(for: Recipe.self, Ingredient.self)
            } catch {
                fatalError("Could not initialize ModelContainer")
            }
        }
    
    var body: some View {
        TabView(){
            RecipesView()
                .tabItem{
                    Image(systemName: "fork.knife")
                    Text("Rezepte")
                }
            CalenderView()
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Kalender")
                }
            RecipesView()
                .tabItem{
                    Image(systemName: "cart")
                    Text("Einkaufsliste")
                }
                .padding()
        }
        .modelContainer(modelContainer)
    }
}
#Preview {
    MainView()
        .modelContainer(previewContainer)
}

