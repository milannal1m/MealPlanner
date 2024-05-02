//
//  ShoppingList.swift
//  Projekt
//
//  Created by Milan Tóth on 27.04.24.
//

import Foundation
import SwiftData

enum validDurations {
    case oneDay
    case twoDays
    case threeDays

    var timeInterval: TimeInterval {
        switch self {
        case .oneDay:
            return 1 * 24 * 60 * 60 // 1 day in seconds
        case .twoDays:
            return 2 * 24 * 60 * 60 // 2 days in seconds
        case .threeDays:
            return 3 * 24 * 60 * 60 // 3 days in seconds
        }
    }
}

class ShoppingList: Identifiable {
    
    var mealsInDuration = [Meal]()
    var duration: TimeInterval

    //Singleton Class -> use with let shoppingList = ShoppingList.shoppingList
    static let shoppingList = ShoppingList()
    private init() {
        self.duration = validDurations.oneDay.timeInterval
    }
    
    func changeDuration(duration:TimeInterval){
        self.duration = duration
    }
    
    func filterMealsByDuration(into context: ModelContext) throws {
        mealsInDuration.removeAll()
        
        //fetches all Meals in ModelContext
        let fetchDescriptor = FetchDescriptor<Meal>()
        let allMeals = try context.fetch(fetchDescriptor)
        
        for meal in allMeals {
            if(IsMealInDuration(meal: meal)){
                mealsInDuration.append(meal)
            }
        }
    }
    
    private func IsMealInDuration(meal:Meal) -> Bool{
        let timeDiffToMeal = self.retrieveTimeDiffToMeal(meal: meal)
        
        return self.duration >= timeDiffToMeal
    }
    
    
    private func retrieveTimeDiffToMeal(meal: Meal) -> TimeInterval{
        let currentDate = Date()
        let timeDiff = meal.scheduledDate.timeIntervalSince(currentDate)
        return timeDiff
    }
    
}
