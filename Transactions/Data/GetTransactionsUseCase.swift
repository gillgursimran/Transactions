//
//  GetTransactionsUseCase.swift
//  Transactions
//
//  Created by Gursimran Singh Gill on 2026-02-03.
//

import Foundation

final class GetTransactionsUseCase {
    private let repository: TransactionRepository

    init(repository: TransactionRepository) {
        self.repository = repository
    }

    func execute() async throws -> [Transaction] {
        try await repository.fetchTransactions()
    }
}
