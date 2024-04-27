//
//  Meal.swift
//  Projekt
//
//  Created by Milan Tóth on 27.04.24.
//

import Foundation
import SwiftData


@Model
class Meal: Identifiable {
    
    let recipe: Recipe
    let scheduledDate: Date

    
    init(recipe: Recipe, scheduledDate: Date) {
        self.recipe = recipe
        self.scheduledDate = scheduledDate
        ShoppingList.shoppingList.allMeals.append(self)
    }
}
