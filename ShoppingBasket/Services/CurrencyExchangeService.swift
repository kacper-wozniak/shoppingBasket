//
//  CurrencyExchangeService.swift
//  ShoppingBasket
//
//  Created by Kacper Woźniak on 29/11/2018.
//  Copyright © 2018 Kacper Woźniak. All rights reserved.
//

import RxSwift

protocol CurrencyExchangeService {

    var currencies: Observable<[String]> { get }
    func convert(price: Price, to currency: String) -> Observable<Price>

}
