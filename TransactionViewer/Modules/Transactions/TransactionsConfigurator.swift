//
//  TransactionsConfigurator.swift
//  TransactionViewer
//
//  Created by Alexander on 03.03.2025.
//

import Foundation

final class TransactionsConfigurator: TransactionsConfiguratorProtocol {

    func configure(with viewController: TransactionsViewController, dataStorage: TransactionsDataStorage) {
        let presenter = TransactionsPresenter(view: viewController)
        let interactor = TransactionsInteractor(presenter: presenter, dataStorage: dataStorage)
        let router = TransactionsRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
