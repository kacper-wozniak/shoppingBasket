//
//  ProductViewCell.swift
//  ShoppingBasket
//
//  Created by Kacper Woźniak on 29/11/2018.
//  Copyright © 2018 Kacper Woźniak. All rights reserved.
//

import UIKit

final class ProductViewCell: UITableViewCell, ReusableCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!

    func configure(using product: Product) {
        nameLabel.text = product.name
        unitLabel.text = product.unit
        priceLabel.text = product.price.description
    }

}
