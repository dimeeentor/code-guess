//
//  WinnerBlockView.swift
//  Code Guesser
//
//  Created by Dmytro Honcharenko on 11.11.2023.
//

import SwiftUI

struct UserNotificationView: View {
    @State var scale = CGSize(width: 0, height: 0)
    let isWon: Bool
    let textIfWon: String
    let textIfLost: String
    private let styles = DefaultStyles()

    var body: some View {
        Text(isWon ? textIfWon : textIfLost)
            .padding(.all, styles.padding)
            .fontDesign(.rounded)
            .font(.title2)
            .fontWeight(.semibold)
            .foregroundStyle(.white)
            .background(isWon ? .green.opacity(0.75) : .pink.opacity(0.75))
            .clipShape(RoundedRectangle(cornerRadius: styles.cornerRadius))
            .shadow(color: styles.primaryShadowColor, radius: styles.primaryShadowRadius)
            .shadow(color: styles.secondaryShadowColor, radius: styles.secondaryShadowRadius)
            .scaleEffect(scale)
            .onAppear {
                withAnimation(.smooth) {
                    scale = CGSize(width: 1, height: 1)
                }
            }
    }
}

#Preview {
    UserNotificationView(isWon: false, textIfWon: "You've guessed the code!", textIfLost: "Unfortunately. You've lost.")
}
