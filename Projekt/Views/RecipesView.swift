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
    @State var recipeStore = RecipeStore.recipeStore
    @Query var recipes: [Recipe]
    @State private var ingredients = [Ingredient]()
    @State private var showCreateRecipe = false
    @State private var showAddIngredients = false
    @State private var recipeName = ""
    @State private var recipeDescription = ""
    @State private var cookingDuration = ""
    @State private var textFieldData: [String] = []
    @State var currentRecipe: Recipe? = nil
    @State var searchText = ""

    
    //@StateObject var textEditorReferenceType: TextEditorReferenceType = TextEditorReferenceType()
    
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
                            Text(recipePreview(recipeDescription: recipe.recipeDescription ?? ""))
                                .font(.system(size:13))
                            Spacer()
                        }
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        //open Recipe View
                    }
                }
            }
            .searchable(text: $searchText)
            .toolbar{
                ToolbarItem(placement: ToolbarItemPlacement.topBarTrailing) {
                    Button{
                        showCreateRecipe = true
                    } label: {
                        Image(systemName: "plus")
                    }
                    .foregroundColor(.black)
                }
                ToolbarItem(placement: ToolbarItemPlacement.topBarLeading) {
                    Text("Recipes")
                        .bold()
                        .font(.system(size:30))
                }
            }
            .alert("Enter new Recipe", isPresented: $showCreateRecipe){
                
                TextField("Name",text:$recipeName)
                
                TextField("Recipe Description",text:$recipeDescription)
                TextField("Cooking Duration",text:$cookingDuration)
                Button("Cancel"){}
                Button("Ok"){
                    currentRecipe = recipeStore.createRecipe(name:recipeName, cookingTime: cookingDuration, recipeDescription: recipeDescription, into: modelContext)
                    showAddIngredients = true
                    recipeName = ""
                    cookingDuration = ""
                    recipeDescription = ""
                }
            }
            .sheet(isPresented: $showAddIngredients){
                IngredientList(recipe: currentRecipe)
            }
        }
    }
}


#Preview {
    RecipesView()
        .modelContainer(previewContainer)
}

