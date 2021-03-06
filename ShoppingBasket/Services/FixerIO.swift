//
//  FixerIO.swift
//  ShoppingBasket
//
//  Created by Kacper Woźniak on 29/11/2018.
//  Copyright © 2018 Kacper Woźniak. All rights reserved.
//

import RxSwift

final class FixerIO: CurrencyExchangeService {

    private let apiKey: String

    init(apiKey: String) {
        self.apiKey = apiKey
    }

    private func rates(for base: String? = nil) -> Observable<CurrencyExchange> {
        let url = "http://data.fixer.io/api/latest?access_key=\(apiKey)" + (base.map { "&base=\($0)" } ?? "")
        return RxAlamofire.request(url: url)
    }

    var currencies: Observable<[String]> {
        return rates().map { Array($0.rates.keys).sorted() }
    }

    func convert(price: Price, to currency: String) -> Observable<Price> {
        return rates(for: price.currency)
            .map { return Price(value: price.value * ($0.rates[currency] ?? 0), currency: currency) }
    }

}
