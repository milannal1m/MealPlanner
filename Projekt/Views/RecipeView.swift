//
//  RecipeView.swift
//  Projekt
//
//  Created by Maximilian Kübler on 06.05.24.
//

import SwiftUI
import SwiftData
import _PhotosUI_SwiftUI

private var startColor = Color(red: 0.94, green: 0.94, blue: 0.86)
private var endColor = Color(red: 217/255, green: 193/255, blue: 165/255)

struct RecipeView: View {
    
    @State var recipe: Recipe
    @State var textDescription = ""
    @State var textButton = "Edit"
    @State var toggleEdit = true
    @State private var selectedPhoto: PhotosPickerItem?
    
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
                                .shadow(radius: 15)
                                .frame(maxWidth: 300,maxHeight: 300)
                                .padding(.top, 20)
                            
                        }else{
                            Image(systemName: "fork.knife")
                                .resizable()
                                .scaledToFit()
                                .shadow(radius: 8)
                                .frame(maxWidth: 200,maxHeight: 200)
                                .padding(.top, 30)
                        }
                        
                        PhotosPicker("Select photo of meal", selection: $selectedPhoto, matching: .images)
                            .padding(.bottom, 20)
                        
                        Text("Recipe")
                            .font(.title2)
                            .bold()
                            .underline()
                            .padding()
                            .background(Rectangle().fill(Color.white).shadow(radius: 5, x: 0, y: 2))
                        TextField("Please enter recipe description", text: $textDescription, axis: .vertical)
                            .foregroundStyle(.black)
                            .background(Color.white)
                            .font(.system(size: 18))
                            .disabled(toggleEdit)
                            .border(Color.black)
                            .padding(.top, 20)
                            .padding(.bottom, 15)
                            .multilineTextAlignment(.center)
                            .lineLimit(10)
                            .frame(width: 300)
                            .lineLimit(3, reservesSpace: true)
                        Text("Ingredients")
                            .font(.title2)
                            .bold()
                            .underline()
                            .padding()
                            .background(Rectangle().fill(Color.white).shadow(radius: 5, x: 0, y: 2))
                        IngredientList(recipe: recipe)
                        Spacer()
                    }
                    .onTapGesture {
                        textDescription = recipe.recipeDescription!
                    }
                    .task(id: selectedPhoto){
                        if let data = try? await selectedPhoto?.loadTransferable(type: Data.self){
                            recipe.imageData = data
                        }
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing){
                        Button{
                            if(textButton == "Edit") {
                                textButton = "Done"
                                toggleEdit = false
                            }
                            else {
                                textButton = "Edit"
                                
                                recipe.recipeDescription = textDescription
                                toggleEdit = true
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
    recipe.addIngredient(name: "Bread1", amount: 50.0, unit: "gramm", into: container.mainContext)

    return RecipeView(recipe: recipe)
        .modelContainer(container)
}
