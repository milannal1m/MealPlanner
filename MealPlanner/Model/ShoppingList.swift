//
//  ShoppingList.swift
//  Projekt
//
//  Created by Milan Tóth on 27.04.24.
//

import Foundation
import SwiftData

enum ValidDuration {
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
    
    var durationString: String{
        switch self {
        case .oneDay:
            return "1 Day"
        case .twoDays:
            return "2 Days"
        case .threeDays:
            return "3 Days"
        }
    }
}

class ShoppingList: Identifiable, ObservableObject {
    
    @Published var shoppingListEntries = [ShoppingListEntry]()
    private var duration: ValidDuration
    private var mealsInDuration = [Meal]()

    
    //Singleton Class -> use with let shoppingList = ShoppingList.shoppingList
    static let shoppingList = ShoppingList()
    private init() {
        self.duration = ValidDuration.oneDay
    }
    
    func updateShoppingList(duration:ValidDuration, into context: ModelContext) throws {
        self.changeDuration(duration: duration)
        try self.filterMealsByDuration(into: context)
        self.updateIngredientsToBuy()
    }
    
    private func changeDuration(duration:ValidDuration){
        self.duration = duration
    }
    
    //Source: https://stackoverflow.com/questions/77945327/how-to-loop-through-data-in-a-swiftdata-model
    private func filterMealsByDuration(into context: ModelContext) throws {
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
        
        return self.duration.timeInterval >= timeDiffToMeal
    }
    
    
    private func retrieveTimeDiffToMeal(meal: Meal) -> TimeInterval{
        let currentDate = Date()
        let timeDiff = meal.scheduledDate.timeIntervalSince(currentDate)
        return timeDiff
    }
    
    private func updateIngredientsToBuy(){
        let allIngredients = self.allIngredientsOfMealsInDuration()
        shoppingListEntries = self.mergedShoppingListEntries(allIngredients: allIngredients)
    }
    
    private func allIngredientsOfMealsInDuration() -> [Ingredient]{
        var allIngredients = [Ingredient]()
        
        for meal in mealsInDuration {
            let ingredients = meal.recipe.ingredients
            allIngredients.append(contentsOf: ingredients)
        }
        
        return allIngredients
    }
    
    
    private func mergedShoppingListEntries(allIngredients:[Ingredient]) -> [ShoppingListEntry]{
        
        //Sources:
        //https://stackoverflow.com/questions/73899414/group-array-by-more-than-one-property-swift
        //https://stackoverflow.com/questions/29727618/find-duplicate-elements-in-array-using-swift

        struct IdenticalIngredientKey: Hashable {
            let name: String
            let unit: String
        }
        
        let identicalIngredients = Dictionary(grouping: allIngredients, by: {IdenticalIngredientKey(name: $0.name.lowercased(), unit: $0.unit.lowercased())})
        
        var shoppingListEntries = [ShoppingListEntry]()
        
        identicalIngredients.forEach { (identicalIngredientKey: IdenticalIngredientKey, identicalIngredients: [Ingredient]) in
            var mergedAmount = Float(0)
            for identicalIngredient in identicalIngredients {
                mergedAmount = mergedAmount + identicalIngredient.amount
            }
            
            let mergedIngredient = Ingredient(name: identicalIngredientKey.name.capitalized(with: nil), amount: mergedAmount, unit: identicalIngredientKey.unit)
            
            let shoppingListEntry = ShoppingListEntry(ingredient: mergedIngredient)
            
            shoppingListEntries.append(shoppingListEntry)
            mergedAmount = 0
        }
        
        return shoppingListEntries
    }
    
}
