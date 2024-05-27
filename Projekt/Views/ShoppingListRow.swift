//
//  ShoppingListRow.swift
//  Projekt
//
//  Created by Milan Tóth on 08.05.24.
//

import SwiftUI

struct ShoppingListRow: View {
    @ObservedObject var shoppingListEntry:ShoppingListEntry
    
    var body: some View {
        HStack{
            Image(systemName: shoppingListEntry.isBought
                  ? "largecircle.fill.circle"
                  : "circle")
                    .imageScale(.large)
                    .foregroundColor(.black)
                    .onTapGesture {
                        shoppingListEntry.isBought.toggle()
                    }
            Text("\(shoppingListEntry.ingredient.name)")
            Text("\(String(format: "%g", shoppingListEntry.ingredient.amount))")
            Text("\(shoppingListEntry.ingredient.unit)")
            
        }

    }
}

//#Preview {
//    ShoppingListRow()
//}
