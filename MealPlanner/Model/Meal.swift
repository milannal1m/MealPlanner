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
    let time: MealTimes

    
    init(recipe: Recipe, scheduledDate: Date, time: MealTimes) {
        self.recipe = recipe
        self.scheduledDate = scheduledDate
        self.time = time
    }
    
    struct mealMetaData: Identifiable {
        var id = UUID().uuidString
        var meal: [Meal]
    }
    
    enum MealTimes: String, CaseIterable, Codable {
        case breakfast = "Breakfast"
        case lunch = "Lunch"
        case dinner = "Dinner"
    }
}
