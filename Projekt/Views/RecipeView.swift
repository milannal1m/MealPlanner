//
//  RecipeView.swift
//  Projekt
//
//  Created by Maximilian Kübler on 06.05.24.
//

import SwiftUI
import SwiftData

private var startColor = Color(red: 0.94, green: 0.94, blue: 0.86)
private var endColor = Color(red: 217/255, green: 193/255, blue: 165/255)

struct RecipeView: View {
    
    @State var recipe: Recipe
    @State var textDescription = ""
    @State var textButton = "Edit"
    @State var toggleDescription = true
    
    var body: some View {
            NavigationStack {
                ZStack {
                    RadialGradient(gradient: Gradient(colors: [startColor, endColor]), center: .center, startRadius: 250, endRadius: 650)
                        .ignoresSafeArea()
                        .edgesIgnoringSafeArea(.all)
                    // https://ashishkakkad.medium.com/gradient-in-swiftui-6c4fc408b7e8
                    VStack{
                        if let imageData = recipe.imageData,
                           let uiImage = UIImage(data: imageData){
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: 100,maxHeight: 100)
                            
                        }else{
                            Image(systemName: "fork.knife")
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: 100,maxHeight: 100)
                                .padding(.top, 30)
                        }
                        TextField("Rezept Beschreibung eingeben", text: $textDescription)
                            .foregroundStyle(.black)
                            .font(.system(size: 18))
                            .disabled(toggleDescription)
                            .padding(.horizontal, 60)
                        Spacer()
                    }
                    .onTapGesture {
                        textDescription = recipe.recipeDescription!
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing){
                        Button{
                            if(textButton == "Edit") {
                                textButton = "Done"
                                toggleDescription = false
                            }
                            else {
                                textButton = "Edit"
                                
                                recipe.recipeDescription = textDescription
                                toggleDescription = true
                            }
                        } label: {
                            Text(textButton)
                                .foregroundStyle(.black)
                                .bold()
                        }
                    }
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
    
    let recipe = Recipe(name: "Spaghetti Bolognese", recipeDescription: "hh")
    
    container.mainContext.insert(recipe)
    
    recipe.addIngredient(name: "Tomato", amount: 5.0, unit: "", into: container.mainContext)
    recipe.addIngredient(name: "Noodles", amount: 500.0, unit: "gramm", into: container.mainContext)
    recipe.addIngredient(name: "Cheese", amount: 50.0, unit: "gramm", into: container.mainContext)
    recipe.addIngredient(name: "Bread", amount: 50.0, unit: "gramm", into: container.mainContext)

    return RecipeView(recipe: recipe)
        .modelContainer(container)
}
