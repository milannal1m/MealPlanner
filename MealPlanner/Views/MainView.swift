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
                modelContainer = try ModelContainer(for: Recipe.self, Ingredient.self, Meal.self)
            } catch {
                fatalError("Could not initialize ModelContainer")
            }
            
            let appearance = UITabBarAppearance()
            appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
                .font: UIFont(name: "Times New Roman", size: 12)!
            ]
            appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
                .font: UIFont(name: "Times New Roman", size: 12)!
            ]

            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = appearance

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
            ShoppingListView()
                .tabItem{
                    Image(systemName: "cart")
                    Text("Einkaufsliste")
                }
                
                .padding()
        }
        .modelContainer(modelContainer)
        .tint(.primary)
        .font(.system(size:30, weight: .heavy, design: .serif))
        
    }
}

#Preview("Deutsch") {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Ingredient.self, Recipe.self, Meal.self, configurations: config)
    
    return MainView()
        .modelContainer(container)
        .environment(\.locale, Locale(identifier: "de"))
}

#Preview("English") {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Ingredient.self, Recipe.self, Meal.self, configurations: config)
    
    return MainView()
        .modelContainer(container)
        .environment(\.locale, Locale(identifier: "en"))
}
