//
//  ProductsRouter.swift
//  TransactionViewer
//
//  Created by Alexander on 03.03.2025.
//

import Foundation

final class ProductsRouter: ProductsRouterProtocol {

    weak var viewController: ProductsViewController!

    required init(viewController: ProductsViewController) {
        self.viewController = viewController
    }

    func showTransactionsScreen(for product: Product) {
        let transactionsViewController = TransactionsViewController()
        let configurator = TransactionsConfigurator()
        let dataStorage = TransactionsDataStorage(product: product)
        configurator.configure(with: transactionsViewController, dataStorage: dataStorage)
        viewController.navigationController?.pushViewController(transactionsViewController, animated: true)
    }
}
