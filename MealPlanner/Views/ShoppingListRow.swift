//
//  ShoppingListRow.swift
//  Projekt
//
//  Created by Milan Tóth on 08.05.24.
//

import SwiftUI

struct ShoppingListRow: View {
    @ObservedObject var shoppingListEntry:ShoppingListEntry
    @ObservedObject var shoppingList = ShoppingList.shoppingList
    
    var body: some View {
        HStack{
            Image(systemName: shoppingListEntry.isBought
                  ? "largecircle.fill.circle"
                  : "circle")
                    .imageScale(.small)
                    .foregroundColor(.primary)
                    .onTapGesture {
                        shoppingListEntry.isBought.toggle()
                        shoppingList.sortShoppingList()
                        
                    }
            (
            Text("\(shoppingListEntry.ingredient.name)   ")
                .font(.system(size:15, weight: .heavy, design: .serif)) +
            Text("\(String(format: "%g", shoppingListEntry.ingredient.amount)) \(shoppingListEntry.ingredient.unit)")
                .font(.system(size:15, weight: .regular, design: .serif))
            )
            .strikethrough(shoppingListEntry.isBought, color: .primary)
            
        }

    }
}

//#Preview {
//    ShoppingListRow()
//}
