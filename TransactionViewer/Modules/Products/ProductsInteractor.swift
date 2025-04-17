//
//  ProductsInteractor.swift
//  TransactionViewer
//
//  Created by Alexander Maklakov on 03.03.2025.
//

import Foundation

final class ProductsInteractor: ProductsInteractorProtocol {
    
    weak var presenter: ProductsPresenterProtocol!

    private var dataService: DataServiceProtocol = DataService()
    private var products: [Product] = []

    required init(presenter: ProductsPresenterProtocol) {
        self.presenter = presenter
    }

    func loadData() {
        Task {
            let transactions = await dataService.loadTransactions()
            
            guard !transactions.isEmpty else {
                await presenter.setError()
                return
            }
            
            products = groupTransactionsBySKU(transactions)
            await presenter.showProducts(products)
        }
    }

    func getProduct(at index: Int) {
        presenter.showTransactions(for: products[index])
    }
}

fileprivate extension ProductsInteractor {
    func groupTransactionsBySKU(_ transactions: [Transaction]) -> [Product] {
        var productDict: [String: [Transaction]] = [:]
        
        for transaction in transactions {
            productDict[transaction.sku, default: []].append(transaction)
        }
        
        return productDict.map { Product(sku: $0.key, transactions: $0.value) }
    }
}
