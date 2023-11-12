//
//  CodeBlockView.swift
//  Code Guesser
//
//  Created by Dmytro Honcharenko on 10.11.2023.
//

import SwiftUI

enum CodeBlock {
    case correct
    case wrongPlace
    case incorrect
}

struct CodeBlockView: View {
    @State private var foregroundOpacity: Double = 0.75
    @State private var background: Color = .white.opacity(0.9)
    @State private var foreground: Color = .black.opacity(0.75)
    private let styles = DefaultStyles()
    private let viewModel = ViewModel()
    
    private func chooseBackground(block: CodeBlock) {
        switch block {
            case .correct:
                background = .green.opacity(0.75)
                foreground = .white
            case .wrongPlace:
                background = .orange.opacity(0.8)
                foreground = .white
            case .incorrect:
                background = .white.opacity(0.9)
                foreground = .black.opacity(styles.foregroundOpacity)
        }
    }
    
    var text: String
    var backgroundColor: CodeBlock
    
    var body: some View {
        Text(text)
            .frame(width: 28, height: 28)
            .padding(.all, styles.padding)
            .font(.title2)
            .fontDesign(.rounded)
            .foregroundStyle(foreground)
            .background(background)
            .overlay {
                RoundedRectangle(cornerRadius: styles.cornerRadius)
                    .foregroundStyle(.fill)
                    .clipShape(RoundedRectangle(cornerRadius: styles.cornerRadius).stroke(lineWidth: styles.lineWidth))
            }
            .clipShape(RoundedRectangle(cornerRadius: styles.cornerRadius))
            .shadow(color: styles.primaryShadowColor, radius: styles.primaryShadowRadius)
            .shadow(color: styles.secondaryShadowColor, radius: styles.secondaryShadowRadius)
            .onChange(of: text) { _, _ in
                foregroundOpacity = 0

                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    withAnimation(.smooth) {
                        self.foregroundOpacity = 0.75
                    }
                }
            }
            .onChange(of: backgroundColor) { chooseBackground(block: backgroundColor) }
            .onAppear { chooseBackground(block: backgroundColor) }
            .animation(.smooth, value: background)
    }
}

#Preview {
    CodeBlockView(text: "?", backgroundColor: .incorrect)
}
