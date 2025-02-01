# MealPlanner

MealPlanner is an iOS application that allows users to manage recipes, plan meals, and automatically creates shopping lists. The app is developed using Swift and SwiftUI and utilizes SwiftData for data management.

The app was developed as part of a student project.

## Table of Contents

- [Installation](#installation)
- [Usage](#usage)
- [Project Structure](#project-structure)
- [Models](#models)
- [Views](#views)
- [Support](#support)
- [Authors](#authors)
- [License](#license)

## Installation

1. Clone the repository:
    ```sh
    git clone https://github.com/milannal1m/MealPlanner-iOS-App.git
    ```
2. Open the project file in Xcode:
    ```sh
    cd project
    open Project.xcodeproj
    ```
3. Ensure you have the correct dependencies installed and run the project on your device or simulator.

## Usage

After launching the app, you can:

- **Add and manage recipes**: Create new recipes, add ingredients, and edit existing recipes.
- **Plan meals**: Schedule meals for specific days in the calendar.
- **Create shopping lists**: Generate shopping lists based on the planned meals.

## Project Structure

```plaintext
Project/
├── Assets.xcassets/
│   ├── AccentColor.colorset/
│   ├── AppIcon.appiconset/
│   └── Contents.json
├── Model/
│   ├── Calendar.swift
│   ├── DateCalendar.swift
│   ├── Ingredient.swift
│   ├── Meal.swift
│   ├── Recipe.swift
│   ├── ShoppingList.swift
│   └── ShoppingListEntry.swift
├── Preview Content/
│   └── Preview Assets.xcassets/
├── Support/
│   └── previewContainer.swift
├── Views/
│   ├── CalenderView.swift
│   ├── IngredientList.swift
│   ├── MainView.swift
│   ├── RecipePickerView.swift
│   ├── RecipeView.swift
│   ├── RecipesView.swift
│   ├── ShoppingListRow.swift
│   └── ShoppingListView.swift
├── ProjektApp.swift
└── Projekt.xcodeproj/
```

## Models ##
* [Calendar: ](Projekt/Model/Calendar.swift)Manages calendar data
* [DateCalendar: ](Projekt/Model/DateCalendar.swift)Manages date entries
* [Ingredient: ](Projekt/Model/Ingredient.swift)Represents an ingredient
* [Meal: ](Projekt/Model/Meal.swift)Stores meal details
* [Recipe: ](Projekt/Model/Recipe.swift)Holds recipe information
* [ShoppingList: ](Projekt/Model/ShoppingList.swift)Tracks the entire shopping list
* [ShoppingListEntry: ](Projekt/Model/ShoppingListEntry.swift)Represents an item in the shopping list

## Views ##
* [CalenderView: ](Projekt/Views/CalenderView.swift)Displays calendar details
* [IngredientList: ](Projekt/Views/IngredientList.swift)Shows a list of ingredients
* [MainView: ](Projekt/Views/MainView.swift)Main application view with navigation
* [RecipePickerView: ](Projekt/Views/RecipePickerView.swift)Enables recipe selection
* [RecipeView: ](Projekt/Views/RecipeView.swift)Displays and edits a single recipe
* [RecipesView: ](Projekt/Views/RecipesView.swift)Manages and displays all recipes
* [ShoppingListRow: ](Projekt/Views/ShoppingListRow.swift)Displays an individual shopping list item
* [ShoppingListView: ](Projekt/Views/ShoppingListView.swift)Displays and manages the entire shopping list
