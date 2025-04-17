//
//  TransactionsInteractor.swift
//  TransactionViewer
//
//  Created by Alexander Maklakov on 03.03.2025.
//

import Foundation

final class TransactionsInteractor: TransactionsInteractorProtocol {
    
    weak var presenter: TransactionsPresenterProtocol!

    private var dataService: DataServiceProtocol = DataService()
    private var dataStorage: TransactionsDataStorage
    private var exchangeRates: [ExchangeRate] = []

    required init(presenter: TransactionsPresenterProtocol, dataStorage: TransactionsDataStorage) {
        self.presenter = presenter
        self.dataStorage = dataStorage
    }

    func loadData() {
        Task {
            exchangeRates = await dataService.loadRates()

            let sku = dataStorage.product.sku
            let transactions = dataStorage.product.transactions.map {
                TransactionFull(amount: Double($0.amount) ?? 0.0, currency: $0.currency, convertedAmount: convertAmount($0))
            }
            let total = transactions.reduce(0.0) { total, transaction in
                total + transaction.convertedAmount
            }
            await presenter.showTransactions(sku, transactions, total)
        }
    }
}

fileprivate extension TransactionsInteractor {
    func convertAmount(_ transaction: Transaction) -> Double {
        if transaction.currency == "GBP" {
            return Double(transaction.amount) ?? 0.0
        }

        var visited = Set<String>()
        return findExchangeRate(from: transaction.currency, to: "GBP", amount: Double(transaction.amount) ?? 0.0, visited: &visited)
    }

    func findExchangeRate(from: String, to: String, amount: Double, visited: inout Set<String>) -> Double {
        if from == to { return amount }
        visited.insert(from)

        if let directRate = exchangeRates.first(where: { $0.from == from && $0.to == to }) {
            return amount * directRate.rate
        }

        for rate in exchangeRates where rate.from == from && !visited.contains(rate.to) {
            let convertedAmount = amount * rate.rate
            let finalAmount = findExchangeRate(from: rate.to, to: to, amount: convertedAmount, visited: &visited)
            if finalAmount > 0 {
                return finalAmount
            }
        }

        return 0.0
    }
}
