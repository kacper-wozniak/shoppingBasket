//
//  BasketViewController.swift
//  ShoppingBasket
//
//  Created by Kacper Woźniak on 29/11/2018.
//  Copyright © 2018 Kacper Woźniak. All rights reserved.
//

import UIKit
import RxSwift

final class BasketViewController: UIViewController {

    private let disposeBag = DisposeBag()

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var checkoutButton: UIButton!

    var viewModel: BasketViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
        setupCheckoutButton()
    }

    private func setupNavigationBar() {
        navigationItem.title = "Basket"
        let addProductButton = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil)
        addProductButton.rx.tap.asDriver().drive(viewModel.addProductButtonTapped).disposed(by: disposeBag)
        navigationItem.setRightBarButtonItems([addProductButton], animated: true)
    }

    private func setupTableView() {
        tableView.register(cell: ProductViewCell.self)
        tableView.rowHeight = 100
        tableView.rx.itemDeleted.asDriver().drive(viewModel.itemDeleted).disposed(by: disposeBag)
        viewModel.items.bind(to: tableView.rx.items(cellIdentifier: ProductViewCell.identifier, cellType: ProductViewCell.self)) { (_, product, cell) in
            cell.configure(using: product)
        }.disposed(by: disposeBag)
    }

    private func setupCheckoutButton() {
        viewModel.canCheckout.bind(to: checkoutButton.rx.isEnabled).disposed(by: disposeBag)
        checkoutButton.rx.tap.asDriver().drive(viewModel.checkoutButtonTapped).disposed(by: disposeBag)
        checkoutButton.layer.cornerRadius = checkoutButton.frame.height/2
    }

}
