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
    @Relationship(inverse:\Ingredient.recipe) var ingredients: [Ingredient] = []
    
    //optional variables
    
    //let Photo
    //let photo: UIImage?
    @Attribute(.externalStorage) var imageData: Data? = nil
    let cookingTime: String? // in minutes
    var recipeDescription: String?
    
    init(name:String, photo:UIImage? = nil, cookingTime:String? = nil, recipeDescription:String? = nil ) {
        self.name = name
        //self.photo = photo
        self.cookingTime = cookingTime
        self.recipeDescription = recipeDescription
    }
    
    func addIngredient(name:String, amount:Float, unit:String, into context: ModelContext){
        let ingredient = Ingredient(name: name,amount:amount,unit: unit)
        self.ingredients.append(ingredient)
        context.insert(ingredient)
    }
}

