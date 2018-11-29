//
//  ProductsViewModel.swift
//  ShoppingBasket
//
//  Created by Kacper Woźniak on 29/11/2018.
//  Copyright © 2018 Kacper Woźniak. All rights reserved.
//

import Foundation
import RxSwift

enum ProductsViewAction {

    case back
    case add(Product)

}

final class ProductsViewModel {

    private let disposeBag = DisposeBag()

    let products = Variable(
        [
            Product(name: "Coffee", unit: "240g", price: Price(value: 2.30, currency: "GBP")),
            Product(name: "Tea", unit: "box of 60", price: Price(value: 3.10, currency: "GBP")),
            Product(name: "Sugar", unit: "1kg", price: Price(value: 2.00, currency: "GBP")),
            Product(name: "Milk", unit: "bottle", price: Price(value: 1.20, currency: "GBP")),
            Product(name: "Cup", unit: "", price: Price(value: 0.50, currency: "GBP"))
        ]
    )

    let action = PublishSubject<ProductsViewAction>()

    let backButtonTapped = PublishSubject<Void>()
    let itemSelected = PublishSubject<IndexPath>()

    init() {
        backButtonTapped.subscribe(onNext: { [weak self] in
            self?.action.onNext(.back)
        }).disposed(by: disposeBag)
        itemSelected.subscribe(onNext: { [weak self] indexPath in
            guard let `self` = self else { return }
            self.action.onNext(.add(self.products.value[indexPath.row]))
        }).disposed(by: disposeBag)
    }

}
