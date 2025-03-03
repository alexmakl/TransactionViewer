//
//  TransactionFull.swift
//  TransactionViewer
//
//  Created by Alexander Maklakov on 03.03.2025.
//

import Foundation

struct TransactionFull: Hashable {
    let amount: Double
    let currency: String
    let convertedAmount: Double
}
