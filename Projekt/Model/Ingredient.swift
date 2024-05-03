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

    init(name: String, amount: Float, unit: String) {
        self.name = name
        self.amount = amount
        self.unit = unit
    }
}

// besprechen mit Maxi
enum IngredientUnit: String, CaseIterable {
    case grams
    case kilograms
    case ounces
    case pounds
    case liter
    case milliLiter
    case none
    
    var displayName: String {
        switch self {
        case .grams:
            return "g"
        case .kilograms:
            return "kg"
        case .ounces:
            return "oz"
        case .pounds:
            return "lb"
        case .none:
            return ""
        case .liter:
            return "l"
        case .milliLiter:
            return "ml"
        }
    }
}
