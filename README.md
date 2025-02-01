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
    git clone https://github.com/your-username/project.git
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
* Calendar: Class for managing calendar data.
* DateCalendar: Structure for managing date entries.
* Ingredient: Class for managing ingredients.
* Meal: Class for managing meals.
* Recipe: Class for managing recipes.
* ShoppingList: Class for managing the shopping list.
* ShoppingListEntry: Class for managing entries in the shopping list.

## Views ##
* [Calendar](Calendar.swift)
* [DateCalendar](DateCalendar.swift)
* [Ingredient](Ingredient.swift)
* [Meal](Meal.swift)
* [Recipe](Recipe.swift)
* [ShoppingList](ShoppingList.swift)
* [ShoppingListEntry](ShoppingListEntry.swift)
