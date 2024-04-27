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
    
    let name: String
    let amount: Float
    let unit: String

    
    init(name: String, amount: Float, unit: String) {
        self.name = name
        self.amount = amount
        self.unit = unit

    }
}

