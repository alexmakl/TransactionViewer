//
//  ProductsPresenter.swift
//  TransactionViewer
//
//  Created by Alexander Maklakov on 03.03.2025.
//

import Foundation

final class ProductsPresenter: ProductsPresenterProtocol {
    

    weak var view: ProductsViewProtocol!
    var interactor: ProductsInteractorProtocol!
    var router: ProductsRouterProtocol!
    
    required init(view: ProductsViewProtocol) {
        self.view = view
    }

    // MARK: ProductsPresenterProtocol methods

    func viewIsReady() {
        interactor.loadData()
    }

    func productTapped(at index: Int) {
        interactor.getProduct(at: index)
    }

    func showTransactions(for product: Product) {
        router.showTransactionsScreen(for: product)
    }

    @MainActor
    func showProducts(_ products: [Product]) {
        let productsToShow: [ProductViewModel] = products.compactMap {
            ProductViewModel(title: $0.sku, transactions: "\($0.transactions.count) transactions")
        }
        view.reloadData(productsToShow)
    }

    @MainActor
    func setError() {
        router.showAlert(message: "No transactions found")
    }
}
