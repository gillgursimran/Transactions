//
//  LocalTransactionsDataSource.swift
//  Transactions
//
//  Created by Gursimran Singh Gill on 2026-02-03.
//

import Foundation

protocol TransactionDataSourceProtocol: Sendable {
    func loadTransactions() async throws -> Data
}

struct LocalTransactionDataSource: TransactionDataSourceProtocol {
    private let fileName: String
    private let fileExtension: String
    
    init(fileName: String = "transaction-list", fileExtension: String = "json") {
        self.fileName = fileName
        self.fileExtension = fileExtension
    }
    
    func loadTransactions() async throws -> Data {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: fileExtension) else {
            throw TransactionDataSourceError.fileNotFound
        }
        
        return try await withCheckedThrowingContinuation { continuation in
            DispatchQueue.global(qos: .userInitiated).async {
                do {
                    let data = try Data(contentsOf: url)
                    continuation.resume(returning: data)
                } catch {
                    continuation.resume(throwing: TransactionDataSourceError.loadingFailed(error))
                }
            }
        }
    }
}

enum TransactionDataSourceError: LocalizedError, Sendable {
    case fileNotFound
    case loadingFailed(Error)
    case decodingFailed(Error)
    
    var errorDescription: String? {
        switch self {
        case .fileNotFound:
            return "Transaction file not found."
        case .loadingFailed(let error):
            return "Failed to load: \(error.localizedDescription)"
        case .decodingFailed(let error):
            return "Failed to decode: \(error.localizedDescription)"
        }
    }
}
