//
//  RecipesView.swift
//  Projekt
//
//  Created by Milan Tóth on 27.04.24.
//

import SwiftUI
import SwiftData
import PhotosUI

struct RecipesView: View {
    @Environment(\.modelContext) private var modelContext
    @Query var recipes: [Recipe]
    @State private var ingredients = [Ingredient]()
    @State private var showCreateRecipe = false
    @State private var showRecipeView = false
    @State private var recipeName = ""
    @State private var textFieldData: [String] = []
    @State var currentRecipe: Recipe = Recipe(name: "Test")
    @State var searchText = ""


    var searchedRecipes: [Recipe] {
        if searchText.isEmpty {
            return recipes
        } else {
            return recipes.filter { $0.name.contains(searchText) }
        }
    }
    
    func recipePreview(recipeDescription: String) -> String{
        
        let shownCharacters = 70
        
        if recipeDescription.utf16.count >= shownCharacters{
            let result = recipeDescription.prefix(shownCharacters)
            return result + " ..."
        }else{
            return recipeDescription
        }
    }
    
    
    var body: some View {
        NavigationStack{
            List {
                ForEach(searchedRecipes, id: \.self) {recipe in
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

                        }
                        .listRowBackground(Color.gray.opacity(0.1))
                        .onTapGesture {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                currentRecipe = recipe
                            }
                            showRecipeView = true
                        }
                        .contentShape(Rectangle())
                    
                }
                .onDelete(perform: { indexSet in
                    for index in indexSet {
                            let recipe = recipes[index]
                            modelContext.delete(recipe)
                        }
                })
            }
            .scrollContentBackground(.hidden)
            .searchable(text: $searchText)
                .font(.system(size:15, weight: .regular, design: .serif))
            .toolbar{
                ToolbarItem(placement: ToolbarItemPlacement.topBarTrailing) {
                    Button{
                        showCreateRecipe = true
                    } label: {
                        Image(systemName: "plus")
                            .font(.system(size:15, weight: .heavy, design: .serif))
                    }
                    .foregroundColor(.primary)
                }
                ToolbarItem(placement: ToolbarItemPlacement.topBarLeading) {
                    Text("Recipes")
                        .font(.system(size:30, weight: .heavy, design: .serif))
                }
            }
            .alert("Enter new Recipe", isPresented: $showCreateRecipe){
                
                TextField("Name",text:$recipeName)
                
                Button("Cancel"){}
                Button("Ok"){
                    currentRecipe = Recipe(name:recipeName)
                    modelContext.insert(currentRecipe)
                    showRecipeView = true
                    recipeName = ""
                }
            }
            .sheet(isPresented: $showRecipeView){
                RecipeView(recipe: currentRecipe)
                    .id(currentRecipe)
            }
        }
        .padding(.top,10)
    }
}


#Preview {
    RecipesView()
        .modelContainer(previewContainer)
}

