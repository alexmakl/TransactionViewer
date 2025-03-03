//
//  DataService.swift
//  TransactionViewer
//
//  Created by Alexander Maklakov on 03.03.2025.
//

import Foundation

protocol DataServiceProtocol {
    func loadTransactions() -> [Transaction]
    func loadRates() -> [ExchangeRate]
}

final class DataService: DataServiceProtocol {

    func loadTransactions() -> [Transaction] {
        guard let path = Bundle.main.path(forResource: "transactions", ofType: "plist"),
              let array = NSArray(contentsOfFile: path) as? [[String: String]] else {
            return []
        }

        return array.compactMap { dict in
            guard let amount = dict["amount"],
                  let currency = dict["currency"],
                  let sku = dict["sku"] else { return nil }

            return Transaction(amount: amount, currency: currency, sku: sku)
        }
    }

    func loadRates() -> [ExchangeRate] {
        guard let path = Bundle.main.path(forResource: "rates", ofType: "plist"),
              let array = NSArray(contentsOfFile: path) as? [[String: String]] else {
            return []
        }

        return array.compactMap { dict in
            guard let from = dict["from"],
                  let rateStr = dict["rate"],
                  let rate = Double(rateStr),
                  let to = dict["to"] else { return nil }

            return ExchangeRate(from: from, rate: rate, to: to)
        }
    }
}
