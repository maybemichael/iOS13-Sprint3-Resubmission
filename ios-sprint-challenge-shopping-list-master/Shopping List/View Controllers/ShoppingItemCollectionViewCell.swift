//
//  ShoppingItemCollectionViewCell.swift
//  Shopping List
//
//  Created by Michael on 1/2/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class ShoppingItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var itemAddedLabel: UILabel!
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemNameLabel: UILabel!
    
    var shoppingItem: ShoppingItem? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        guard let shoppingItem = shoppingItem else { return }
        
        itemImageView.image = UIImage(named: shoppingItem.itemName)
        itemNameLabel.text = shoppingItem.itemName
        
        if shoppingItem.itemAdded {
            itemAddedLabel.text = "Added"
        } else {
            itemAddedLabel.text = "Not Added"
        }
    }
}
