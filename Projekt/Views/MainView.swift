//
//  ContentView.swift
//  Projekt
//
//  Created by Milan Tóth on 23.04.24.
//

import SwiftUI

struct MainView: View {
    
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
    }
}
#Preview {
    MainView()
}


