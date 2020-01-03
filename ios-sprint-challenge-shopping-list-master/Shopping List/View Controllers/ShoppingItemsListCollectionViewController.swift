//
//  ShoppingItemsListCollectionViewController.swift
//  Shopping List
//
//  Created by Michael on 1/2/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

private let reuseIdentifier = "ShoppingItemCell"

class ShoppingItemsListCollectionViewController: UICollectionViewController {

    var shoppingListController = ShoppingListController()
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView?.reloadData()
    }

    
    
    
    // MARK: - Navigation

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PlaceOrderSegue" {
            guard let placeOrderVC = segue.destination as? PlaceOrderViewController else { return }
            
            let itemsInCart = shoppingListController.itemsInCart()
            placeOrderVC.itemCount = itemsInCart
        }
    }
    

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var itemCount = 0
        if section == 0 {
            itemCount = shoppingListController.itemsNotAdded.count
        } else {
            itemCount = shoppingListController.itemsAdded.count
        }
        return itemCount
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? ShoppingItemCollectionViewCell else { return UICollectionViewCell()}
    
        // Configure the cell
        let shoppingItem = itemsAdded(indexPath: indexPath)
//        let shoppingItem = shoppingListController.shoppingItemsList[indexPath.item]
        cell.shoppingItem = shoppingItem
        
        return cell
    }
    
    private func itemsAdded(indexPath: IndexPath) -> ShoppingItem {
        if indexPath.section == 0 {
            return shoppingListController.itemsNotAdded[indexPath.item]
        } else {
            return shoppingListController.itemsAdded[indexPath.item]
        }
    }
    
    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? ShoppingItemCollectionViewCell, let item = cell.shoppingItem else { return }
        
        shoppingListController.toggleAddItem(item: item)
        
        collectionView.reloadData()
    }
}
