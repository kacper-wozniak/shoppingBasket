//
//  Price.swift
//  ShoppingBasket
//
//  Created by Kacper Woźniak on 29/11/2018.
//  Copyright © 2018 Kacper Woźniak. All rights reserved.
//

import Foundation

struct Price: CustomStringConvertible {

    let value: Float
    let currency: String

    var description: String {
        return String(format: "%.2f %@", value, currency)
    }

    static let zero = Price(value: 0, currency: "GBP")

    static func * (price: Price, amount: Int) -> Price {
        return Price(value: price.value * Float(amount),
                     currency: price.currency)
    }

    static func + (lhs: Price, rhs: Price) -> Price {
        return Price(value: lhs.value + rhs.value,
                     currency: lhs.currency)
    }

}
