//
//  CustomNavigationBar.swift
//  Transactions
//
//  Created by Gursimran Singh Gill on 2026-02-04.
//

import SwiftUI

struct CustomNavigationBar: View {
    let title: String

    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .center) {
                Text(title)
                    .title2Style()
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color(.white))
        }
        .padding(.bottom)
        .overlay(
            Rectangle()
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Colors.shadowColor.opacity(0.1),
                            Color.clear.opacity(0.0)
                        ]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .frame(height: 15),
            alignment: .bottom
        )
    }
}

#Preview {
    CustomNavigationBar(title: "Title")
}
