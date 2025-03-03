//
//  TransactionsInteractor.swift
//  TransactionViewer
//
//  Created by Alexander on 03.03.2025.
//

import Foundation

final class TransactionsInteractor: TransactionsInteractorProtocol {
    
    weak var presenter: TransactionsPresenterProtocol!

    private var dataService: DataServiceProtocol = DataService()
    private var dataStorage: TransactionsDataStorage

    required init(presenter: TransactionsPresenterProtocol, dataStorage: TransactionsDataStorage) {
        self.presenter = presenter
        self.dataStorage = dataStorage
    }

    func loadData() {
        let sku = dataStorage.product.sku
        let transactions = dataStorage.product.transactions
        presenter.showTransactions(sku, transactions)
    }
}

fileprivate extension TransactionsInteractor {
    func groupTransactionsBySKU(_ transactions: [Transaction]) -> [Product] {
        var productDict: [String: [Transaction]] = [:]
        
        for transaction in transactions {
            productDict[transaction.sku, default: []].append(transaction)
        }
        
        return productDict.map { Product(sku: $0.key, transactions: $0.value) }
    }
}
