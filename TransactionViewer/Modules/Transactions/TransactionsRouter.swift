//
//  TransactionsRouter.swift
//  TransactionViewer
//
//  Created by Alexander Maklakov on 03.03.2025.
//

import Foundation

final class TransactionsRouter: TransactionsRouterProtocol {

    weak var viewController: TransactionsViewController!

    required init(viewController: TransactionsViewController) {
        self.viewController = viewController
    }
}
