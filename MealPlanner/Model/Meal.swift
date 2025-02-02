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
    
    @Attribute(.unique) let id = UUID()
    let recipe: Recipe
    let scheduledDate: Date

    
    init(recipe: Recipe, scheduledDate: Date) {
        self.recipe = recipe
        self.scheduledDate = scheduledDate
    }
    
    struct mealMetaData: Identifiable {
        var id = UUID().uuidString
        var meal: [Meal]
    }
}
