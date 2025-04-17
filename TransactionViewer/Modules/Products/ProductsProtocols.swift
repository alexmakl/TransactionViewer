//
//  ProductsProtocols.swift
//  TransactionViewer
//
//  Created by Alexander Maklakov on 03.03.2025.
//

import Foundation

protocol ProductsViewProtocol: AnyObject {
    func reloadData(_ products: [ProductViewModel])
}

protocol ProductsPresenterProtocol: AnyObject {
    func viewIsReady()
    func productTapped(at index: Int)

    func showTransactions(for product: Product)
    @MainActor
    func showProducts(_ products: [Product])
    @MainActor
    func setError()
}

protocol ProductsInteractorProtocol {
    func loadData()
    func getProduct(at index: Int)
}

protocol ProductsRouterProtocol {
    func showAlert(message: String)
    func showTransactionsScreen(for product: Product)
}

protocol ProductsConfiguratorProtocol {
    func configure(with viewController: ProductsViewController)
}
