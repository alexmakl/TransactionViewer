//
//  TransactionsPresenter.swift
//  TransactionViewer
//
//  Created by Alexander Maklakov on 03.03.2025.
//

import Foundation

final class TransactionsPresenter: TransactionsPresenterProtocol {
    

    weak var view: TransactionsViewProtocol!
    var interactor: TransactionsInteractorProtocol!
    var router: TransactionsRouterProtocol!
    
    required init(view: TransactionsViewProtocol) {
        self.view = view
    }

    // MARK: TransactionsPresenterProtocol methods

    func viewIsReady() {
        interactor.loadData()
    }

    func showTransactions(_ sku: String, _ transactions: [TransactionFull], _ total: Double) {
        view.updateTitle("Transactions for \(sku)")
        let gbpSymbol = "GBP".currencySymbol

        let transactionsToShow: [TransactionViewModel] = transactions.compactMap {
            TransactionViewModel(
                amount: String(format: "\($0.currency.currencySymbol)%.2f", $0.amount),
                convertedAmount: String(format: "\(gbpSymbol)%.2f", $0.convertedAmount)
            )
        }
        view.reloadData(title: String(format: "Total: \(gbpSymbol)%.2f", total), transactionsToShow)
    }
}
