//
//  previewContainer.swift
//  Projekt
//
//  Created by Milan Tóth on 29.04.24.
//

import SwiftData

@MainActor
let previewContainer: ModelContainer = {
    do {
        let container = try ModelContainer (
            for: Recipe.self,
            Ingredient.self,
            Meal.self,
            configurations: ModelConfiguration(isStoredInMemoryOnly: true)
        )
        return container
    } catch {
        fatalError("Failed to create container")
    }
}()
