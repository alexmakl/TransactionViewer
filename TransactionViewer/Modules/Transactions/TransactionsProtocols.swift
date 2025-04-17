//
//  TransactionsProtocols.swift
//  TransactionViewer
//
//  Created by Alexander Maklakov on 03.03.2025.
//

import Foundation

@MainActor
protocol TransactionsViewProtocol: AnyObject {
    func updateTitle(_ text: String)
    func reloadData(title: String, _ transactions: [TransactionViewModel])
}

protocol TransactionsPresenterProtocol: AnyObject {
    func viewIsReady()

    @MainActor
    func showTransactions(_ sku: String, _ transactions: [TransactionFull], _ total: Double)
}

protocol TransactionsInteractorProtocol {
    func loadData()
}

protocol TransactionsRouterProtocol {}

protocol TransactionsConfiguratorProtocol {
    func configure(with viewController: TransactionsViewController, dataStorage: TransactionsDataStorage)
}
