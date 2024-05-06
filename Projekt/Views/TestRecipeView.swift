//
//  TestRecipeView.swift
//  Projekt
//
//  Created by Milan Tóth on 06.05.24.
//

import SwiftUI
import SwiftData
import PhotosUI

// Source https://www.youtube.com/watch?v=y3LofRLPUM8

struct TestRecipeView: View {
    
    @State private var selectedPhoto: PhotosPickerItem?
    @Environment(\.modelContext) private var modelContext
    var recipe: Recipe?
    
    
    
    var body: some View {
        HStack {
            Text("\(recipe!.name)")
            
            
            //Das benutzen um recipe.Image einzufügen mit -> else Default Image
            if let imageData = recipe!.imageData,
               let uiImage = UIImage(data: imageData){
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth:.infinity,maxHeight: 300)
                
            }
            // bis hier
            
            PhotosPicker("Select avatar", selection: $selectedPhoto, matching: .images)
            
            
        }
        .task(id: selectedPhoto){
            if let data = try? await selectedPhoto?.loadTransferable(type: Data.self){
                recipe!.imageData = data
            }
        }
    }
    
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Ingredient.self, Recipe.self, configurations: config)
    
    let recipe = Recipe(name: "Placeholder")
    
    container.mainContext.insert(recipe)
    
    return TestRecipeView(recipe: recipe)
        .modelContainer(container)
    
}

