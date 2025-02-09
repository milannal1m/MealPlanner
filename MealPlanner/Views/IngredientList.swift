//
//  IngredientList.swift
//  Projekt
//
//  Created by Milan Tóth on 29.04.24.
//

import SwiftUI
import SwiftData

struct IngredientList: View {
    
    var recipe: Recipe?
    @State var name = ""
    @State var amountText = ""
    @State var unit = ""
    @State var showAdd = false
    @State var showEdit = false
    @State var tappedIngredientIdx = 0
    @Environment(\.modelContext) private var modelContext
    
    //Source: https://developer.apple.com/documentation/swiftdata/deleting-persistent-data-from-your-app
    
    func removeIngredients(at indexSet: IndexSet){
        for index in indexSet {
            let ingredientToDelete = recipe!.ingredients[index]
            modelContext.delete(ingredientToDelete)
        }
    }
    
    var body: some View {
                VStack(spacing: -10) {
                    HStack(alignment: .center, spacing: 10) {
                        Text("Ingredients")
                            .font(.system(size:25, weight: .heavy, design: .serif))
                        
                        Spacer()
                        
                        Button {
                            showAdd = true
                        } label: {
                            Image(systemName: "plus")
                                .font(.system(size:15, weight: .heavy, design: .serif))
                                .foregroundStyle(.primary)
                        }
                    }
                    .padding(.horizontal)
                    List{
                        let tagsArray = Array(zip(recipe!.ingredients.indices, recipe!.ingredients))
                        ForEach(tagsArray, id: \.0) { index, ingredient in
                            HStack {
                                Text(ingredient.name)
                                    .font(.system(size:15, weight: .heavy, design: .serif))
                                
                                
                                Spacer()
                                Text("\(String(format: "%g", ingredient.amount)) \(ingredient.unit)")
                                    .font(.system(size:15, weight: .regular, design: .serif))
                                
                                    .font(.subheadline)
                            }
                            .listRowBackground(Color.gray.opacity(0.1))
                            .contentShape(Rectangle())
                            .onTapGesture{
                                tappedIngredientIdx = index
                                name = ingredient.name
                                amountText = String(ingredient.amount)
                                unit = ingredient.unit
                                showEdit = true
                            }
                        }
                        .onDelete(perform: removeIngredients)
            }
            .scrollContentBackground(.hidden)
            .alert("Add Ingredient", isPresented: $showAdd){

                TextField("Name",text:$name)
                TextField("Amount",text:$amountText)
                    .keyboardType(.decimalPad)
                TextField("Unit",text:$unit)
                Button("Cancel"){}
                Button("Ok"){
                    recipe?.addIngredient(name: name, amount: Float(amountText) ?? 0.0, unit: unit, into: modelContext)
                    name = ""
                    amountText = ""
                    unit = ""
                }
            }
            .alert("Edit tag", isPresented: $showEdit){
                TextField("Name",text:$name)
                TextField("Amount",text:$amountText)
                    .keyboardType(.decimalPad)
                TextField("Unit",text:$unit)
                Button("Cancel"){}
                Button("Ok"){
                    recipe!.ingredients[tappedIngredientIdx].name = name
                    recipe!.ingredients[tappedIngredientIdx].amount = Float(amountText) ?? 0.0
                    recipe!.ingredients[tappedIngredientIdx].unit = unit
                }
            }
        }
    }
}







#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Ingredient.self, Recipe.self, configurations: config)
    
    let recipe = Recipe(name: "Placeholder")
    
    container.mainContext.insert(recipe)
    
    recipe.addIngredient(name: "Tomato", amount: 5.0, unit: "", into: container.mainContext)
    recipe.addIngredient(name: "Noodles", amount: 500.0, unit: "gramm", into: container.mainContext)
    recipe.addIngredient(name: "Cheese", amount: 50.0, unit: "gramm", into: container.mainContext)

    return IngredientList(recipe: recipe)
        .modelContainer(container)
}
