//
//  PrimaryButtonView.swift
//  Code Guesser
//
//  Created by Dmytro Honcharenko on 10.11.2023.
//

import SwiftUI

struct PrimaryButtonView: View {
    let text: String
    let action: () -> Void
    private let styles = DefaultStyles()

    var body: some View {
        Button(action: { action() }) {
            Text(text)
                .frame(width: 70)
                .padding(.all, styles.padding)
                .background(.background.opacity(0.9))
                .foregroundStyle(.foreground.opacity(styles.foregroundOpacity))
                .fontDesign(.rounded)
                .overlay {
                    RoundedRectangle(cornerRadius: styles.cornerRadius)
                        .foregroundStyle(.fill)
                        .clipShape(RoundedRectangle(cornerRadius: styles.cornerRadius).stroke(lineWidth: styles.lineWidth))
                }
                .clipShape(RoundedRectangle(cornerRadius: styles.cornerRadius))
                .shadow(color: styles.primaryShadowColor, radius: styles.primaryShadowRadius)
                .shadow(color: styles.secondaryShadowColor, radius: styles.secondaryShadowRadius)
        }
    }
}

#Preview {
    PrimaryButtonView(text: "Guess", action: { })
}
