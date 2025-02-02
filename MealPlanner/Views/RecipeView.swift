//
//  RecipeView.swift
//  Projekt
//
//  Created by Maximilian Kübler on 06.05.24.
//

import SwiftUI
import SwiftData
import _PhotosUI_SwiftUI

struct RecipeView: View {
    
    @State var recipe: Recipe
    @State var toggleEdit = true
    @State private var selectedPhoto: PhotosPickerItem?
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack{
                    if let imageData = recipe.imageData,
                       let uiImage = UIImage(data: imageData){
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 300,maxHeight: 300)
                            .padding(.top, 20)
                        
                    }else{
                        Image(systemName: "fork.knife")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 200,maxHeight: 200)
                            .padding(.top, 30)
                    }
                    
                    PhotosPicker("Select photo of meal", selection: $selectedPhoto, matching: .images)
                        .padding(.bottom, 20)
                    
                    IngredientList(recipe: recipe)
                }
                .task(id: selectedPhoto){
                    if let data = try? await selectedPhoto?.loadTransferable(type: Data.self){
                        recipe.imageData = data
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading){
                    Text(recipe.name)
                        .bold()
                        .font(.system(size: 26))
                }
            }
        }
    }
}


#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Ingredient.self, Recipe.self, configurations: config)
    
    let recipe = Recipe(name: "Spaghetti Bolognese")
    
    container.mainContext.insert(recipe)
    
    recipe.addIngredient(name: "Tomato", amount: 5.0, unit: "", into: container.mainContext)
    recipe.addIngredient(name: "Noodles", amount: 500.0, unit: "gramm", into: container.mainContext)
    recipe.addIngredient(name: "Cheese", amount: 50.0, unit: "gramm", into: container.mainContext)
    recipe.addIngredient(name: "Bread", amount: 50.0, unit: "gramm", into: container.mainContext)
    
    return RecipeView(recipe: recipe)
        .modelContainer(container)
}
