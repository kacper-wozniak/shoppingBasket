//
//  CurrencyExchange.swift
//  ShoppingBasket
//
//  Created by Kacper Woźniak on 29/11/2018.
//  Copyright © 2018 Kacper Woźniak. All rights reserved.
//

import Foundation

struct CurrencyExchange: Decodable {

    let base: String
    let rates: [String: Float]

}
