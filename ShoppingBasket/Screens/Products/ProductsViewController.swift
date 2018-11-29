//
//  ProductsViewController.swift
//  ShoppingBasket
//
//  Created by Kacper Woźniak on 29/11/2018.
//  Copyright © 2018 Kacper Woźniak. All rights reserved.
//

import UIKit
import RxSwift

final class ProductsViewController: UITableViewController {

    private let disposeBag = DisposeBag()

    var viewModel: ProductsViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
    }

    private func setupNavigationBar() {
        navigationItem.title = "Add product"
        let backButton = UIBarButtonItem(barButtonSystemItem: .stop, target: nil, action: nil)
        backButton.rx.tap.asDriver().drive(viewModel.backButtonTapped).disposed(by: disposeBag)
        navigationItem.setLeftBarButton(backButton, animated: true)
    }

    private func setupTableView() {
        tableView.register(cell: ProductViewCell.self)
        tableView.rowHeight = 100
        tableView.rx.itemSelected.asDriver().drive(viewModel.itemSelected).disposed(by: disposeBag)
        viewModel.products.asObservable().bind(to: tableView.rx.items(cellIdentifier: ProductViewCell.identifier, cellType: ProductViewCell.self)) {
            (_, product, cell) in cell.configure(using: product)
        }.disposed(by: disposeBag)
    }

}
