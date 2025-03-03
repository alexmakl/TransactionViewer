//
//  ProductsRouter.swift
//  TransactionViewer
//
//  Created by Alexander Maklakov on 03.03.2025.
//

import Foundation
import UIKit

final class ProductsRouter: ProductsRouterProtocol {

    weak var viewController: ProductsViewController!

    required init(viewController: ProductsViewController) {
        self.viewController = viewController
    }

    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        viewController?.present(alert, animated: true)
    }

    func showTransactionsScreen(for product: Product) {
        let transactionsViewController = TransactionsViewController()
        let configurator = TransactionsConfigurator()
        let dataStorage = TransactionsDataStorage(product: product)
        configurator.configure(with: transactionsViewController, dataStorage: dataStorage)
        viewController.navigationController?.pushViewController(transactionsViewController, animated: true)
    }
}
