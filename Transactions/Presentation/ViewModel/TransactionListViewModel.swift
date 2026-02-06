//
//  TransactionListViewModel.swift
//  Transactions
//
//  Created by Gursimran Singh Gill on 2026-02-03.
//

import Foundation
import SwiftUI
import Combine

@MainActor
final class TransactionListViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published private(set) var transactions: [Transaction] = []
    @Published private(set) var isLoading = false
    @Published private(set) var error: Error?
    
    private let getTransactionsUseCase: GetTransactionsUseCase
    
    init(getTransactionsUseCase: GetTransactionsUseCase) {
        self.getTransactionsUseCase = getTransactionsUseCase
    }
       
    func loadTransactions() async {
        isLoading = true
        error = nil
        
        do {
            transactions = try await getTransactionsUseCase.execute()
        } catch {
            self.error = error
            transactions = []
        }
        
        isLoading = false
    }
    
    func retry() {
        Task {
            await loadTransactions()
        }
    }
}

