//
//  ShoppingListController.swift
//  Shopping List
//
//  Created by Michael on 1/2/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

class ShoppingListController {
    
    var shoppingItemsList: [ShoppingItem] = []
    
    func createShoppingItemList() {
        let itemNames = ["Apple", "Grapes", "Milk", "Muffin", "Popcorn", "Soda", "Strawberries"]
        
        for item in itemNames {
            let shopItem = ShoppingItem(itemName: item)
            shoppingItemsList.append(shopItem)
        }
    }
    
    func toggleAddItem(item: ShoppingItem) {
        guard let itemSelected = shoppingItemsList.firstIndex(of: item) else { return }
        shoppingItemsList[itemSelected].itemAdded.toggle()
    }
    
    func itemsInCart() -> Int {
        let itemsCountArray = shoppingItemsList.filter {$0.itemAdded}
        return itemsCountArray.count
    }
    
    var shoppingListURL: URL? {
        let fileManager = FileManager.default
        
        guard let documentDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        let itemsURL = documentDir.appendingPathComponent("ShoppingList.plist")
        
        return itemsURL
    }
    
    func saveToPersistentStore() {
        guard let itemsURL = shoppingListURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            
            let shoppingItemsData = try encoder.encode(shoppingItemsList)
            
            try shoppingItemsData.write(to: itemsURL)
        } catch {
            print("Error saving data: \(error).")
        }
    }
    
    func loadFromPersistentStore() {
        do {
            guard let itemsURL = shoppingListURL else { return }
            
            let shoppingItemsData = try Data(contentsOf: itemsURL)
            
            let decoder = PropertyListDecoder()
            
            let shoppingItemArray = try decoder.decode([ShoppingItem].self, from: shoppingItemsData)
            
            self.shoppingItemsList = shoppingItemArray
        } catch {
            print("Error loading data from plist: \(error).")
        }
    }
    
    init() {
        let shoppingItemsInitialized = UserDefaults.standard.bool(forKey: "ItemsInitialized")
        
        if shoppingItemsInitialized {
            loadFromPersistentStore()
        } else {
            createShoppingItemList()
            saveToPersistentStore()
            UserDefaults.standard.set(true, forKey: "ItemsInitialized")
        }
    }
}
