//
//  TransactionListView.swift
//  Transactions
//
//  Created by Gursimran Singh Gill on 2026-02-03.
//

import SwiftUI

struct TransactionListView: View {
    @StateObject private var viewModel: TransactionListViewModel
    
    init(viewModel: TransactionListViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                CustomNavigationBar(title: "Transactions")
                Spacer(minLength: 0)
                ZStack {
                    if viewModel.isLoading {
                        loadingView
                    } else if let error = viewModel.error {
                        errorView(error)
                    } else {
                        transactionList
                    }
                }
                Spacer(minLength: 0)
            }
            .task {
                await viewModel.loadTransactions()
            }
        }
    }
    
    private var loadingView: some View {
        ProgressView("Loading transactions...")
    }
    
    private func errorView(_ error: Error) -> some View {
        ErrorView(
            error: error,
            retryAction: { viewModel.retry() }
        )
    }
    
    private var transactionList: some View {
        List(viewModel.transactions) { transaction in
            NavigationLink {
                TransactionDetailView(transaction: transaction)
            } label: {
                TransactionRowView(transaction: transaction)
                    .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
        }
        .listStyle(.plain)
    }
}

// MARK: - Transaction Row View
struct TransactionRowView: View {
    let transaction: Transaction
    
    var body: some View {
        HStack(spacing: Spacing.large) {
            Image("success-icon")
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .foregroundColor(transaction.isCredit ? .green : .red)
            
            VStack(alignment: .leading, spacing: Spacing.xSmall) {
                Text(transaction.merchantName)
                    .font(.subheadline)
                    .foregroundColor(.primary)
                
                Text(transaction.description)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            Text("$\(transaction.formattedAmount())")
                .font(.headline)
        }
        .padding(.vertical, Spacing.small)
    }
}

// MARK: - Error View
struct ErrorView: View {
    let error: Error
    let retryAction: () -> Void
    
    var body: some View {
        VStack(spacing: Spacing.large) {
            Text("Error loading transactions")
                .font(.headline)
            
            Text(error.localizedDescription)
                .font(.caption)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Button("Retry", action: retryAction)
                .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

// MARK: - Preview
#Preview {
    let repository = TransactionRepository()
    let useCase = GetTransactionsUseCase(repository: repository)
    let viewModel = TransactionListViewModel(getTransactionsUseCase: useCase)
    TransactionListView(viewModel: viewModel)
}
