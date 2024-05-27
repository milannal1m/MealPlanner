//
//  ShoppingListEntry.swift
//  Projekt
//
//  Created by Milan Tóth on 07.05.24.
//

import Foundation

class ShoppingListEntry: Identifiable, ObservableObject{
    
    let id = UUID()
    let ingredient: Ingredient
    @Published var isBought: Bool = false
    
    init(ingredient: Ingredient) {
        self.ingredient = ingredient
    }
}
