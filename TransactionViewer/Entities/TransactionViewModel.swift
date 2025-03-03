//
//  TransactionViewModel.swift
//  TransactionViewer
//
//  Created by Alexander Maklakov on 03.03.2025.
//

import Foundation

struct TransactionViewModel: Hashable {
    let id = UUID()
    let amount: String
    let convertedAmount: String

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: TransactionViewModel, rhs: TransactionViewModel) -> Bool {
        return lhs.id == rhs.id
    }
}
