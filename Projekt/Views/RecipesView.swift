//
//  RecipesView.swift
//  Projekt
//
//  Created by Milan Tóth on 27.04.24.
//

import SwiftUI
import SwiftData

struct RecipesView: View {
    @Environment(\.modelContext) private var modelContext
    @State var recipeStore = RecipeStore.recipeStore
    @Query var recipes: [Recipe]
    
    var body: some View {
        NavigationStack{
            VStack{
                ForEach(recipes) { recipe in
                    Text("\(recipe.name)")
                }
            }
            .toolbar{
                ToolbarItem(placement: ToolbarItemPlacement.topBarLeading) {
                    Button{
                        print("Hello")
                        recipeStore.createRecipe(name: "Test", into: modelContext)
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            
        }
        
    }
}
#Preview {
    RecipesView()
        .modelContainer(previewContainer)
}
