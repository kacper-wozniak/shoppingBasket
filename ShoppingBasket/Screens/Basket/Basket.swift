//
//  Basket.swift
//  ShoppingBasket
//
//  Created by Kacper Woźniak on 29/11/2018.
//  Copyright © 2018 Kacper Woźniak. All rights reserved.
//

import Foundation
import RxSwift

struct Basket {

    let items = Variable<[Product]>([])

    var totalPrice: Price {
        return items.value.map { $0.price }
            .reduce(.zero, +)
    }

    func add(_ product: Product) {
        items.value.append(product)
    }

    func remove(at indexPath: IndexPath) {
        items.value.remove(at: indexPath.row)
    }

}
