//
//  CheckoutViewModel.swift
//  ShoppingBasket
//
//  Created by Kacper Woźniak on 29/11/2018.
//  Copyright © 2018 Kacper Woźniak. All rights reserved.
//

import RxSwift

final class CheckoutViewModel {

    private let currencyExchangeService: CurrencyExchangeService
    private let totalPrice: Price

    let selectedCurrency: Variable<String>

    init(totalPrice: Price, currencyExchangeService: CurrencyExchangeService) {
        self.currencyExchangeService = currencyExchangeService
        self.totalPrice = totalPrice
        self.selectedCurrency = Variable(totalPrice.currency)
    }

    var currencies: Observable<[String]> {
        return currencyExchangeService.currencies
    }

    var preselectedCurrencyIndex: Observable<Int> {
        return currencies.map { [weak self] currencies in
            guard let `self` = self else { return 0 }
            return currencies.firstIndex(of: self.totalPrice.currency) ?? 0
        }
    }

    var totalPriceText: Observable<String> {
        return selectedCurrency.asObservable()
            .flatMapLatest { [weak self] currency -> Observable<String> in
                guard let `self` = self else { return .just("") }
                return self.currencyExchangeService.convert(price: self.totalPrice, to: currency).map { $0.description }
        }
    }

}
