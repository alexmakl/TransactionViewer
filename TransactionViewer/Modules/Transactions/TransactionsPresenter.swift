//
//  TransactionsPresenter.swift
//  TransactionViewer
//
//  Created by Alexander on 03.03.2025.
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

    func showTransactions(_ sku: String, _ transactions: [Transaction]) {
        view.updateTitle("Transactions for \(sku)")

        let transactionsToShow: [TransactionViewModel] = transactions.compactMap {
            TransactionViewModel(amount: $0.amount, convertedAmount: "\($0.currency) \($0.amount)")
        }
        view.reloadData(title: "Total: ", transactionsToShow)
    }
}
