//
//  RecipeStore.swift
//  Projekt
//
//  Created by Milan Tóth on 29.04.24.
//

import Foundation
import OSLog
import SwiftData

@Observable
class RecipeStore{
    
    var allRecipes: [Recipe] = []
    let logger = Logger(subsystem:Bundle.main.bundleIdentifier!, category: "RecipeStore")
    
    //Singleton Class -> use with let recipeStore = RecipeStore.recipeStore
    static let recipeStore = RecipeStore()
    private init() {}
    
    @MainActor
    func createRecipe(name:String, cookingTime:Float? = nil, recipeDescription:String? = nil, into context: ModelContext){
        logger.info("\(name) recipe created.")
        let recipe = Recipe(name: name,cookingTime: cookingTime, recipeDescription: recipeDescription)
        self.allRecipes.append(recipe)
        context.insert(recipe)
    }
}
