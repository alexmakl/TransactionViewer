//
//  TransactionsProtocols.swift
//  TransactionViewer
//
//  Created by Alexander on 03.03.2025.
//

import Foundation

protocol TransactionsViewProtocol: AnyObject {
    func updateTitle(_ text: String)
    func reloadData(title: String, _ transactions: [TransactionViewModel])
}

protocol TransactionsPresenterProtocol: AnyObject {
    func viewIsReady()

    func showTransactions(_ sku: String, _ transactions: [Transaction])
}

protocol TransactionsInteractorProtocol {
    func loadData()
}

protocol TransactionsRouterProtocol {}

protocol TransactionsConfiguratorProtocol {
    func configure(with viewController: TransactionsViewController, dataStorage: TransactionsDataStorage)
}
