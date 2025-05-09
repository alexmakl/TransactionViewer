//
//  Transaction.swift
//  TransactionViewer
//
//  Created by Alexander Maklakov on 03.03.2025.
//

import Foundation

struct Transaction: Hashable {
    let amount: String
    let currency: String
    let sku: String
}
