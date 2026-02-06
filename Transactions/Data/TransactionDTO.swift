//
//  TransactionDTO.swift
//  Transactions
//
//  Created by Gursimran Singh Gill on 2026-02-03.
//

import Foundation

struct TransactionDTO: Codable, Sendable {
    let id: String?
    let transactionType: String?
    let merchantName: String?
    let description: String?
    let amount: AmountDTO?
    let postedDate: String?
    let fromAccount: String?
    let fromCardNumber: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "key"
        case transactionType = "transaction_type"
        case merchantName = "merchant_name"
        case description
        case amount
        case postedDate = "posted_date"
        case fromAccount = "from_account"
        case fromCardNumber = "from_card_number"
    }
}

struct AmountDTO: Codable, Sendable {
    let value: Double
    let currency: String
}

struct TransactionListResponseDTO: Codable, Sendable {
    let transactions: [TransactionDTO]
}

extension TransactionDTO {
    func toDomain() throws -> Transaction {
        guard let id else {
            throw TransactionMappingError.missingRequiredField("id")
        }
        
        guard let transactionType = TransactionType(rawValue: transactionType ?? "") else {
            throw TransactionMappingError.missingRequiredField("transactionType")
        }
        
        guard let merchantName else {
            throw TransactionMappingError.missingRequiredField("merchantName")
        }
        
        let description = description ?? ""
        
        guard let amount = amount else {
            throw TransactionMappingError.missingRequiredField("amount")
        }
        
        guard let postedDate else {
            throw TransactionMappingError.missingRequiredField("postedDate")
        }
        
        guard let fromAccount  else {
            throw TransactionMappingError.missingRequiredField("fromAccount")
        }
        
        guard let fromCardNumber else {
            throw TransactionMappingError.missingRequiredField("fromCardNumber")
        }
            
        let domainAmount = Amount(value: amount.value, currency: amount.currency)

        return Transaction(
            id: id,
            transactionType: transactionType,
            merchantName: merchantName,
            description: description,
            amount: domainAmount,
            postedDate: postedDate,
            fromAccount: fromAccount,
            fromCardNumber: fromCardNumber
        )
    }
}

enum TransactionMappingError: Error, Sendable {
    case missingRequiredField(String)
    
    var errorDescription: String? {
        switch self {
        case .missingRequiredField(let missingField):
            return "Missing required field: \(missingField)"
        }
    }
}
