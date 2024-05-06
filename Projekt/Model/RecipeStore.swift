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
    
    private let logger = Logger(subsystem:Bundle.main.bundleIdentifier!, category: "RecipeStore")
    
    //Singleton Class -> use with let recipeStore = RecipeStore.recipeStore
    static let recipeStore = RecipeStore()
    private init() {}
    
    @discardableResult func createRecipe(name:String, cookingTime:String? = nil, recipeDescription:String? = nil, into context: ModelContext) -> Recipe {
        logger.info("\(name) recipe created.")
        let recipe = Recipe(name: name,cookingTime: cookingTime, recipeDescription: recipeDescription)
        context.insert(recipe)
        
        return recipe
    }

}
