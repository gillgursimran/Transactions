//
//  TransactionsApp.swift
//  Transactions
//
//  Created by Gursimran Singh Gill on 2026-02-03.
//

import SwiftUI

@main
struct TransactionsApp: App {
    var body: some Scene {
        WindowGroup {
            let transactionRepository = TransactionRepository()
            let getTransactionsUseCase = GetTransactionsUseCase(repository: transactionRepository)
            let viewModel = TransactionListViewModel(getTransactionsUseCase: getTransactionsUseCase)
            TransactionListView(viewModel: viewModel)
        }
    }
}
