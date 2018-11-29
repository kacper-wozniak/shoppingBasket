//
//  BasketViewModel.swift
//  ShoppingBasket
//
//  Created by Kacper Woźniak on 29/11/2018.
//  Copyright © 2018 Kacper Woźniak. All rights reserved.
//

import Foundation
import RxSwift

enum BasketViewAction {

    case addProduct((Product) -> Void)
    case checkout(Price)

}

final class BasketViewModel {

    private let disposeBag = DisposeBag()
    private let basket = Basket()

    let action = PublishSubject<BasketViewAction>()

    let checkoutButtonTapped = PublishSubject<Void>()
    let addProductButtonTapped = PublishSubject<Void>()
    let itemDeleted = PublishSubject<IndexPath>()

    init() {
        checkoutButtonTapped.subscribe(onNext: { [weak self] in
            guard let `self` = self else { return }
            self.action.onNext(.checkout(self.basket.totalPrice))
        }).disposed(by: disposeBag)
        addProductButtonTapped.subscribe(onNext: { [weak self] in
            self?.action.onNext(.addProduct { self?.basket.add($0) })
        }).disposed(by: disposeBag)
        itemDeleted.subscribe(onNext: { [weak self] indexPath in
            self?.basket.remove(at: indexPath)
        }).disposed(by: disposeBag)
    }

    var items: Observable<[Product]> {
        return basket.items.asObservable()
    }

    var canCheckout: Observable<Bool> {
        return basket.items.asObservable().map { !$0.isEmpty }
    }

}
