//
//  Text+Styling.swift
//  Transactions
//
//  Created by Gursimran Singh Gill on 2026-02-04.
//

import SwiftUI

struct Title2TextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title2)
            .foregroundColor(.primary)
    }
}

struct Title3TextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title3)
            .foregroundColor(.primary)
    }
}

struct SubtitleTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .foregroundColor(.secondary)
    }
}

struct DefaultTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.body)
            .foregroundColor(.primary)
    }
}

struct SecondaryTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.secondary)
    }
}

extension View {
    func title2Style() -> some View {
        modifier(Title2TextStyle())
    }

    func title3Style() -> some View {
        modifier(Title3TextStyle())
    }
    
    func subtitleStyle() -> some View {
        modifier(SubtitleTextStyle())
    }
    
    func defaultStyle() -> some View {
        modifier(DefaultTextStyle())
    }
    
    func secondaryStyle() -> some View {
        modifier(SecondaryTextStyle())
    }
}
