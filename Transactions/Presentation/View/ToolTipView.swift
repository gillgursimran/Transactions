//
//  ToolTipView.swift
//  Transactions
//
//  Created by Gursimran Singh Gill on 2026-02-03.
//

import SwiftUI

struct ToolTipView: View {
    @State private var isExpanded = false
    
    ///All strings used in the app including these can be moved to Localized file
    private let originalMessage = "Transactions are processed Monday to Friday (excluding holidays)."
    private let expandedMessage = "Transactions made before 8:30 pm ET Monday to Friday (excluding holidays) will show up in your account the same day."
    
    var body: some View {
        HStack(alignment: .top) {
            Image("buddy-tip-icon")
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
            
            VStack(alignment: .leading, spacing: 12) {
                Text(originalMessage)
                    .defaultStyle()
                
                if isExpanded {
                    Text(expandedMessage)
                        .defaultStyle()
                }
                
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        isExpanded.toggle()
                    }
                }) {
                    Text(isExpanded ? "Show less" : "Show more")
                        .font(.headline)
                        .foregroundColor(.blue)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: CornerRadius.smallCornerRadius)
                .fill(Color.white)
                .shadow(
                    color: Colors.shadowColor.opacity(0.20),
                    radius: 3,
                    x: 3,
                    y: 3
                )
        )
        .overlay(
            RoundedRectangle(cornerRadius: CornerRadius.smallCornerRadius)
                .stroke(Colors.strokeColor, lineWidth: 1)
        )
    }
}

#Preview {
    ToolTipView()
        .padding()
}
