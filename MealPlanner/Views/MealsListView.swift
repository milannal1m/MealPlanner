import SwiftUI

struct MealsListView: View {
    
    @Binding var meals: [Meal]
    @State var currentRecipe: Recipe? = nil
    @State private var showRecipeView = false
    @Binding var showRecipePickerView: Bool
    @State private var selectedMealTime: Meal.MealTimes? = nil
    @Binding var pickedDate: Date
    @Environment(\.modelContext) private var modelContext
    var shoppingList = ShoppingList.shoppingList
    
    var body: some View {
        List {
            ForEach(Meal.MealTimes.allCases, id: \.self) { time in
                let filteredMeals = meals.filter { $0.time == time }
                
                Section(
                    header: HStack {
                        Text(NSLocalizedString(time.rawValue, comment: ""))
                            .font(.system(size: 17, weight: .heavy, design: .serif))
                            .foregroundColor(.primary)
                        Spacer()
                        Button(action: {
                            selectedMealTime = time
                            showRecipePickerView = true
                        }) {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(.primary)
                                .font(.system(size: 17, weight: .heavy, design: .serif))
                        }
                    }
                ) {
                    ForEach(filteredMeals, id: \.self) { meal in
                        HStack {
                            if let imageData = meal.recipe.imageData,
                               let uiImage = UIImage(data: imageData) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxWidth: 30, maxHeight: 30)
                            } else {
                                Image(systemName: "fork.knife")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxWidth: 30, maxHeight: 30)
                            }
                            
                            Text(meal.recipe.name)
                                .font(.system(size: 15, weight: .heavy, design: .serif))
                        }
                        .onTapGesture {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                currentRecipe = meal.recipe
                            }
                            showRecipeView = true
                        }
                    }
                    .onDelete { indexSet in
                        for index in indexSet {
                            let mealToDelete = filteredMeals[index]
                            modelContext.delete(mealToDelete)
                        }
                        do { try shoppingList.updateShoppingList(duration: shoppingList.duration, into: modelContext) } catch {}
                    }
                }
            }
        }
        .onChange(of: showRecipePickerView) {
            currentRecipe = meals.last?.recipe ?? nil
            do { try shoppingList.updateShoppingList(duration: shoppingList.duration, into: modelContext) } catch {}
        }
        .scrollContentBackground(.hidden)
        .sheet(isPresented: $showRecipeView) {
            RecipeView(recipe: currentRecipe ?? Recipe(name: "Something went wrong"))
                .id(currentRecipe)
        }
        .sheet(isPresented: $showRecipePickerView) {
            if let mealTime = selectedMealTime {
                RecipePickerView(pickedDate: pickedDate, time: selectedMealTime!)
            }
        }
    }
}

