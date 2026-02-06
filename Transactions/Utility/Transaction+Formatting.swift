//
//  Transaction+Formatting.swift
//  Transactions
//
//  Created by Gursimran Singh Gill on 2026-02-03.
//

import Foundation

extension Transaction {
    func formattedAmount() -> String {
        return "\(String(format: "%.2f", amount.value))"
    }
    
    func formattedPostedDate() -> String {
        guard let postedDate = ISO8601DateFormatter().date(from: postedDate) else {
            return "Unknown date"
        }
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: postedDate)
    }
}
