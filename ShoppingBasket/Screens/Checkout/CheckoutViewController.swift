//
//  CheckoutViewController.swift
//  ShoppingBasket
//
//  Created by Kacper Woźniak on 29/11/2018.
//  Copyright © 2018 Kacper Woźniak. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class CheckoutViewController: UIViewController {

    private let disposeBag = DisposeBag()

    @IBOutlet weak var currencyPickerView: UIPickerView!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var orderButton: UIButton!

    var viewModel: CheckoutViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupCurrencyPicker()
        setupTotalPriceLabel()
        setupOrderButton()
    }

    private func setupNavigationBar() {
        navigationItem.title = "Checkout"
    }

    private func setupCurrencyPicker() {
        //TODO - find a way to reduce network calls and execute them in serial manner
        currencyPickerView.rx.modelSelected(String.self).asDriver().map { $0.first! }.drive(viewModel.selectedCurrency).disposed(by: disposeBag)
        viewModel.currencies.observeOn(MainScheduler.instance).bind(to: currencyPickerView.rx.itemTitles){ $1 }.disposed(by: disposeBag)
        viewModel.preselectedCurrencyIndex.observeOn(MainScheduler.instance).subscribe(onNext: { [weak self] index in
            self?.currencyPickerView.selectRow(index, inComponent: 0, animated: true)
        }).disposed(by: disposeBag)
    }

    private func setupTotalPriceLabel() {
        viewModel.totalPriceText.bind(to: totalPriceLabel.rx.text).disposed(by: disposeBag)
    }

    private func setupOrderButton() {
        orderButton.layer.cornerRadius = orderButton.frame.height/2
    }

}
