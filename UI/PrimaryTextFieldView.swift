//
//  PrimaryTextFieldView.swift
//  Code Guesser
//
//  Created by Dmytro Honcharenko on 10.11.2023.
//

import SwiftUI

struct MaxLengthModifier: ViewModifier {
    let maxLength: Int
    @Binding var text: String

    func body(content: Content) -> some View {
        content
            .onChange(of: text, { _, newValue in
                if newValue.count > maxLength {
                    self.text = String(newValue.prefix(maxLength))
                }
            })
    }
}

struct PrimaryTextFieldView: View {
    private let styles = DefaultStyles()
    let placeholder: String
    var text: Binding<String>
    var action: () -> Void

    var body: some View {
        TextField(placeholder, text: text)
            .padding(.all, styles.padding)
            .background(.background)
            .fontDesign(.rounded)
            .foregroundStyle(.foreground.opacity(styles.foregroundOpacity))
            .overlay {
                RoundedRectangle(cornerRadius: styles.cornerRadius)
                    .foregroundStyle(.fill)
                    .clipShape(RoundedRectangle(cornerRadius: styles.cornerRadius).stroke(lineWidth: styles.lineWidth))
            }
            .clipShape(RoundedRectangle(cornerRadius: styles.cornerRadius))
            .shadow(color: styles.primaryShadowColor, radius: styles.primaryShadowRadius)
            .shadow(color: styles.secondaryShadowColor, radius: styles.secondaryShadowRadius)
            .keyboardType(.numberPad)
            .zIndex(2)
            .onSubmit { action() }
            .modifier(MaxLengthModifier(maxLength: 4, text: text))
    }
}

#Preview {
    PrimaryTextFieldView(placeholder: "Guess the code...", text: .constant(""), action: { })
}
