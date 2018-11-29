//
//  ReusableCell.swift
//  ShoppingBasket
//
//  Created by Kacper Woźniak on 29/11/2018.
//  Copyright © 2018 Kacper Woźniak. All rights reserved.
//

import Foundation

protocol ReusableCell {}

extension ReusableCell {

    static var identifier: String { return String(describing: self) }

}
