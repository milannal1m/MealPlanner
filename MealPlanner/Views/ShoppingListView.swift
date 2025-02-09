//
//  ShoppingView.swift
//  Projekt
//
//  Created by Milan Tóth on 27.04.24.
//

import SwiftUI
import SwiftData
import OSLog

struct ShoppingListView: View {
    
    @Environment(\.modelContext) private var modelContext
    @ObservedObject var shoppingList = ShoppingList.shoppingList
    let duration = ValidDuration.oneDay
    private let logger = Logger(subsystem:Bundle.main.bundleIdentifier!, category: "ShoppingView")
    let validDurations = [ValidDuration.oneDay, ValidDuration.twoDays, ValidDuration.threeDays, ValidDuration.fourDays, ValidDuration.fiveDays, ValidDuration.sixDays, ValidDuration.week]
    @State var selectedDuration = ValidDuration.oneDay
    @State private var hasAppeared = false
    
    
    var body: some View {
        NavigationStack{
            VStack {
                if shoppingList.shoppingListEntries.isEmpty {
                    Text("No Meals planned")
                        .font(.system(size:20, weight: .heavy, design: .serif))
                        .foregroundColor(.gray.opacity(0.7))
                        .padding(.top,50)
                    
                    
                    Text(NSLocalizedString("for the selected duration", comment: ""))
                        .font(.system(size:20, weight: .heavy, design: .serif))
                        .foregroundColor(.gray.opacity(0.7))
                        .padding(.top,5)
                    
                    Spacer()
                    
                } else {
                    List {
                        ForEach(shoppingList.shoppingListEntries) { entry in
                            ShoppingListRow(shoppingListEntry: entry)
                        }
                        .listRowBackground(Color.gray.opacity(0.1))
                    }
                    .scrollContentBackground(.hidden)
                }
            }
            .toolbar{
                ToolbarItem(placement: ToolbarItemPlacement.topBarTrailing) {
                    Picker("", selection: $selectedDuration) {
                        ForEach(validDurations, id: \.self) {
                            Text("\($0.durationString)")
                                .font(.system(size:15, weight: .regular, design: .serif))
                        }
                        
                    }
                    .font(.system(size:15, weight: .regular, design: .serif))
                    .accentColor(.primary)
                    .onChange(of: selectedDuration){
                        do {
                            try shoppingList.updateShoppingList(duration: selectedDuration, into: modelContext)
                            logger.info("Updating Shopping List Succeeded")
                        } catch {
                            logger.info("Updating Shopping List Failed")
                        }
                    }
                    .onAppear {
                        if !hasAppeared {
                            do {
                                try shoppingList.updateShoppingList(duration: selectedDuration, into: modelContext)
                                logger.info("Updating Shopping List Succeeded")
                            } catch {
                                logger.info("Updating Shopping List Failed")
                            }
                            hasAppeared = true
                        }
                    }
                }
                ToolbarItem(placement: ToolbarItemPlacement.topBarLeading) {
                    Text("Shopping List")
                        .font(.system(size:30, weight: .heavy, design: .serif))
                }
            }
        }
        
        
    }
}


#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Ingredient.self, Recipe.self, Meal.self, configurations: config)
    
    let recipe = Recipe(name: "Placeholder")
    
    container.mainContext.insert(recipe)
    
    recipe.addIngredient(name: "Tomato", amount: 5.0, unit: "", into: container.mainContext)
    recipe.addIngredient(name: "Noodles", amount: 500.0, unit: "gramm", into: container.mainContext)
    recipe.addIngredient(name: "Cheese", amount: 50.0, unit: "gramm", into: container.mainContext)
    
    //https://stackoverflow.com/questions/54084023/how-to-get-the-todays-and-tomorrows-date-in-swift-4
    
    let calendar = Calendar.current
    
    let today = Date()
    let midnight = calendar.startOfDay(for: today)
    
    let tomorrow = calendar.date(byAdding: .day, value: 1, to: midnight)!
    
    let dayAfterTomorrow = calendar.date(byAdding: .day, value: 2, to: midnight)!
    
    let mealToday = Meal(recipe: recipe, scheduledDate: today, time: Meal.MealTimes.breakfast)
    let mealTomorrow = Meal(recipe: recipe, scheduledDate: tomorrow, time: Meal.MealTimes.lunch)
    let mealDayAfterTomorrow = Meal(recipe: recipe, scheduledDate: dayAfterTomorrow, time: Meal.MealTimes.dinner)
    
    container.mainContext.insert(mealToday)
    container.mainContext.insert(mealTomorrow)
    container.mainContext.insert(mealDayAfterTomorrow)
    
    return ShoppingListView()
        .modelContainer(container)
}

