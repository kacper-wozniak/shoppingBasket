//
//  ShoppingFlowCoordinator.swift
//  ShoppingBasket
//
//  Created by Kacper Woźniak on 29/11/2018.
//  Copyright © 2018 Kacper Woźniak. All rights reserved.
//

import UIKit
import RxSwift

class ShoppingFlowCoordinator {

    private let basketDisposeBag = DisposeBag()
    private var productsDisposeBag = DisposeBag()

    let navigationViewController = UINavigationController()

    init() {
        showBasket()
    }

    func showBasket() {
        let viewController = BasketViewController()
        let viewModel = BasketViewModel()
        viewController.viewModel = viewModel
        viewModel.action.subscribe(onNext: { [weak self] action in
            switch action {
            case .addProduct(let addedProduct): self?.showProducts(addedProduct: addedProduct)
            case .checkout(let totalPrice): self?.showCheckout(totalPrice: totalPrice)
            }
        }).disposed(by: basketDisposeBag)
        navigationViewController.pushViewController(viewController, animated: true)
    }

    func showProducts(addedProduct: @escaping (Product) -> Void) {
        let viewController = ProductsViewController()
        let viewModel = ProductsViewModel()
        viewController.viewModel = viewModel
        viewModel.action.subscribe(onNext: { action in
            switch action {
            case .back: break
            case .add(let product): addedProduct(product)
            }
            viewController.dismiss(animated: true) { [weak self] in
                self?.productsDisposeBag = DisposeBag()
            }
        }).disposed(by: productsDisposeBag)
        navigationViewController.present(UINavigationController(rootViewController: viewController), animated: true)
    }

    func showCheckout(totalPrice: Price) {
        let viewController = CheckoutViewController()
        let viewModel = CheckoutViewModel(totalPrice: totalPrice, currencyExchangeService: ExchangeRatesApiIO())
        viewController.viewModel = viewModel
        navigationViewController.pushViewController(viewController, animated: true)
    }

}
