//
//  Recipe.swift
//  Projekt
//
//  Created by Milan Tóth on 27.04.24.
//

import Foundation
import SwiftData
import UIKit

@Model
class Recipe: Identifiable {
    
    //member Variables
    @Attribute(.unique) let id = UUID()
    let name: String
    @Relationship(deleteRule: .cascade, inverse:\Ingredient.recipe) var ingredients: [Ingredient] = []
    @Relationship(deleteRule: .cascade, inverse:\Meal.recipe) var meals: [Meal] = []
    
    //optional variables

    @Attribute(.externalStorage) var imageData: Data? = nil

    
    init(name:String, photo:UIImage? = nil) {
        self.name = name
    }
    
    func addIngredient(name:String, amount:Float, unit:String, into context: ModelContext){
        let ingredient = Ingredient(name: name,amount:amount,unit: unit, recipe:self)
        self.ingredients.append(ingredient)
        context.insert(ingredient)
    }
    
    func addMeals(date:Date, into context: ModelContext){
        let meal = Meal(recipe: self, scheduledDate: date)
        context.insert(meal)
    }
}

