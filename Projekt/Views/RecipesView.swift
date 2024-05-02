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
    @State private var ingredients = [Ingredient]()
    @State private var showCreateRecipe = false
    @State private var showAddIngredients = false
    @State private var recipeName = ""
    @State private var recipeDescription = ""
    @State private var cookingDuration = ""
    @State private var textFieldData: [String] = []
    @State var currentRecipe: Recipe? = nil
    
    //@StateObject var textEditorReferenceType: TextEditorReferenceType = TextEditorReferenceType()
    
    var body: some View {
        NavigationStack{
            VStack{
                ForEach(recipes) { recipe in
                    Text("\(recipe.name)")
                }
            }
            .toolbar{
                ToolbarItem(placement: ToolbarItemPlacement.topBarTrailing) {
                    Button{
                        showCreateRecipe = true
                    } label: {
                        Image(systemName: "plus")
                    }
                    .foregroundColor(.black)
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
                    
                    //Open IngredientList
                    
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

