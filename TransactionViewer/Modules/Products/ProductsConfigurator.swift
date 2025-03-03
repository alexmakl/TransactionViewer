//
//  ProductsConfigurator.swift
//  TransactionViewer
//
//  Created by Alexander Maklakov on 03.03.2025.
//

import Foundation

final class ProductsConfigurator: ProductsConfiguratorProtocol {

    func configure(with viewController: ProductsViewController) {
        let presenter = ProductsPresenter(view: viewController)
        let interactor = ProductsInteractor(presenter: presenter)
        let router = ProductsRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
