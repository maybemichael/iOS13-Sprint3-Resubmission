//
//  PlaceOrderViewController.swift
//  Shopping List
//
//  Created by Michael on 1/2/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class PlaceOrderViewController: UIViewController {

    @IBOutlet weak var itemCountLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    
    var itemCount: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    @IBAction func placeOrderTapped(_ sender: Any) {
        guard let name = nameTextField.text, let address = addressTextField.text, !name.isEmpty, !address.isEmpty else { return }
        
        let orderAlert = UIAlertController(title: "Thank you \(name)!", message: "Your order will be delivered to \(address) in 15 minutes.", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Ok", style: .default) {
            orderAlert in self.navigationController?.popToRootViewController(animated: true)
        }
        orderAlert.addAction(action)
        present(orderAlert, animated: true)
    }
    
    
    
    func updateViews() {
        guard let itemCount = itemCount else { return }
        
        itemCountLabel.text = "You currently have \(itemCount) item(s) in your shopping list."
    }
}
