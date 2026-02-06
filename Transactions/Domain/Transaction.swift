//
//  Transaction.swift
//  Transactions
//
//  Created by Gursimran Singh Gill on 2026-02-03.
//

import Foundation

struct Transaction: Sendable, Identifiable {
    let id: String
    let transactionType: TransactionType
    let merchantName: String
    let description: String
    let amount: Amount
    let postedDate: String
    let fromAccount: String
    let fromCardNumber: String
    
    var isCredit: Bool {
        transactionType == .credit
    }
}

struct Amount: Sendable {
    let value: Double
    let currency: String
}

enum TransactionType: String, Sendable, Codable {
    case credit = "CREDIT"
    case debit = "DEBIT"
}
