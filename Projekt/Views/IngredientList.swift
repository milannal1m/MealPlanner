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
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        NavigationStack {
            List{
                ForEach(recipe!.ingredients) { ingredient in
                    HStack {
                        Text(ingredient.name)
                            .font(.headline)
                        
                        
                        Spacer()
                        Text("\(String(format: "%g", ingredient.amount)) \(ingredient.unit)")
                        
                            .font(.subheadline)
                    }
                }
                .onDelete(perform: { indexSet in
                    // Delete + Update noch machen
                })
                
            }
            .toolbar{
                ToolbarItem(placement: ToolbarItemPlacement.topBarTrailing) {
                    Button{
                        showAdd = true
                    } label: {
                        Image(systemName: "plus")
                            .foregroundColor(.black)
                    }
                }
                ToolbarItem(placement: ToolbarItemPlacement.topBarLeading){
                    Text("Ingredients")
                        .fontWeight(.bold)
                        .font(.title)
                }
            }
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
