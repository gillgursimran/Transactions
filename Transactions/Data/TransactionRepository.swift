//
//  TransactionRepository.swift
//  Transactions
//
//  Created by Gursimran Singh Gill on 2026-02-03.
//

import Foundation

protocol TransactionRepositoryProtocol {
    func fetchTransactions() async throws -> [Transaction]
}

final class TransactionRepository: @unchecked Sendable {
    private let dataSource: TransactionDataSourceProtocol
    
    init(dataSource: TransactionDataSourceProtocol = LocalTransactionDataSource()) {
        self.dataSource = dataSource
    }
}

extension TransactionRepository: TransactionRepositoryProtocol {
    func fetchTransactions() async throws -> [Transaction] {
        let data = try await dataSource.loadTransactions()
        return try decodeTransactions(from: data)
    }
    
    private func decodeTransactions(from data: Data) throws -> [Transaction] {
        do {
            let decoder = JSONDecoder()
            let response = try decoder.decode(TransactionListResponseDTO.self, from: data)
            return try response.transactions.map { try $0.toDomain() }
        } catch let error as TransactionMappingError {
            throw error
        } catch {
            throw TransactionDataSourceError.decodingFailed(error)
        }
    }
}
