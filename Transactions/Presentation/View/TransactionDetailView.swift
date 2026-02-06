//
//  TransactionDetailView.swift
//  Transactions
//
//  Created by Gursimran Singh Gill on 2026-02-03.
//

import SwiftUI

struct TransactionDetailView: View {
    let transaction: Transaction
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                CustomNavigationBar(title: "Transaction Details")
                Spacer(minLength: 0)
                GeometryReader { geometry in
                    ScrollView {
                        VStack(spacing: Spacing.xLarge) {
                            headerSection
                            detailsSection
                            ToolTipView()
                                .padding(.vertical, Spacing.xLarge)
                            Spacer()
                            closeButton
                        }
                        .padding(Spacing.large)
                        .frame(maxWidth: .infinity)
                        .frame(minHeight: geometry.size.height
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: CornerRadius.largeCornerRadius)
                                .stroke(Colors.strokeColor, lineWidth: 1)
                        )
                    }
                    .padding(.horizontal)
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
    
    private var headerSection: some View {
        VStack(spacing: Spacing.large) {
            Image("success-icon")
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
                .foregroundColor(transaction.isCredit ? .green : .red)
            
            Text(transaction.isCredit ? "Credit transaction" : "Debit transaction")
                .title2Style()
        }
    }
    
    private var detailsSection: some View {
        VStack(alignment: .leading, spacing: Spacing.large) {
            AccountDetailRow(
                title: "From",
                account: transaction.fromAccount,
                card: transaction.fromCardNumber
            )
            Divider()
            AmountDetailRow(title: "Amount", value: transaction.formattedAmount())
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var closeButton: some View {
        VStack(spacing: Spacing.large) {
            Button(action: {
                dismiss()
            }) {
                Text("Close")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 60)
                    .background(
                        RoundedRectangle(cornerRadius: CornerRadius.smallCornerRadius)
                            .fill(.red)
                    )
            }
        }
    }
}

struct AccountDetailRow: View {
    let title: String
    let account: String
    let card: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.small) {
            Text(title)
                .secondaryStyle()
            
            HStack(spacing: Spacing.xSmall) {
                Text(account)
                    .title3Style()
                
                Text(String("(\(card.prefix(4)))"))
                    .font(.title3)
                    .foregroundColor(.secondary)
            }
        }
    }
}

struct AmountDetailRow: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.small) {
            Text(title)
                .secondaryStyle()
            Text("$ \(value)")
                .title3Style()
        }
    }
}

#Preview {
    TransactionDetailView(transaction: Transaction(
        id: "1",
        transactionType: TransactionType.credit,
        merchantName: "Coffee Shop",
        description: "Morning coffee",
        amount: Amount(value: 25.00, currency: "CAD"),
        postedDate: String("\(Date())"),
        fromAccount: "Debit",
        fromCardNumber: "3597573657333"
    ))
}
