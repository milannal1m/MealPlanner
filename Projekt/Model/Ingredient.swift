//
//  Ingredient.swift
//  Projekt
//
//  Created by Milan Tóth on 27.04.24.
//

import Foundation
import SwiftData

@Model
class Ingredient: Identifiable {
    
    @Attribute(.unique) let id = UUID()
    var name: String
    var amount: Float
    var unit: String
    var recipe: Recipe? = nil

    init(name: String, amount: Float, unit: String, recipe:Recipe? = nil) {
        self.name = name
        self.amount = amount
        self.unit = unit
        self.recipe = recipe
    }
}
