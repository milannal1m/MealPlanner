//
//  RecipePickerView.swift
//  Projekt
//
//  Created by Milan Tóth on 01.06.24.
//

import SwiftUI
import SwiftData

struct RecipePickerView: View {
    @Environment(\.modelContext) private var modelContext
    @State var recipeStore = RecipeStore.recipeStore
    @Query var recipes: [Recipe]
    @State var searchText = ""
    @State var pickedDate: Date
    
    var searchedRecipes: [Recipe] {
        if searchText.isEmpty {
            return recipes
        } else {
            return recipes.filter { $0.name.contains(searchText) }
        }
    }
    
    var body: some View {
        NavigationStack {
            List {
                    ForEach(searchedRecipes, id: \.self) { recipe in
                        HStack {
                            if let imageData = recipe.imageData,
                               let uiImage = UIImage(data: imageData){
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxWidth: 75,maxHeight: 75)
                                
                            }else{
                                Image(systemName: "fork.knife")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxWidth: 75,maxHeight: 75)
                            }
                            
                            VStack {
                                Text("\(recipe.name)")
                                    .bold()
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .padding(5)
                                Spacer()
                            }
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            let meal = Meal(recipe: recipe, scheduledDate: pickedDate)
                            modelContext.insert(meal)
                        }

                    }
                }
            .searchable(text: $searchText)
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Ingredient.self, Recipe.self, Meal.self, configurations: config)
    
    let recipe = Recipe(name: "Placeholder")
    let recipe2 = Recipe(name: "Placeholder")
    let recipe3 = Recipe(name: "Placeholder")
    
    container.mainContext.insert(recipe)
    container.mainContext.insert(recipe2)
    container.mainContext.insert(recipe3)
    
    return RecipePickerView(pickedDate: Date())
        .modelContainer(container)
}

