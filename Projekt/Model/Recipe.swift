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
    let name: String
    var Inngredients = [Ingredient]()
    
    //optional variables
    
    // let Photo
    //let photo: UIImage?
    let cookingTime: Float? // in minutes
    let recipeDescription: String?
    
    init(name:String, photo:UIImage? = nil, cookingTime:Float? = nil, recipeDescription:String? = nil ) {
        self.name = name
        //self.photo = photo
        self.cookingTime = cookingTime
        self.recipeDescription = recipeDescription
    }
}

