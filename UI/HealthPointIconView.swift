//
//  HealthPointIcon.swift
//  Code Guesser
//
//  Created by Dmytro Honcharenko on 10.11.2023.
//

import SwiftUI

struct HealthPointIconView: View {
    @State var scale = CGSize(width: 0, height: 0)
    let isDead: Bool
    let viewModel = ViewModel()
    let styles = DefaultStyles()
    

    var body: some View {
        Image(systemName: "heart.fill")
            .font(.largeTitle)
            .foregroundStyle(!isDead ? .pink.opacity(styles.foregroundOpacity) : .secondary.opacity(0.25))
            .shadow(color: styles.primaryShadowColor, radius: styles.primaryShadowRadius)
            .shadow(color: styles.secondaryShadowColor, radius: styles.secondaryShadowRadius)
            .scaleEffect(scale)
            .onAppear {
                let baseAnimation = Animation.bouncy(duration: 0.5, extraBounce: 0.2).delay(0.5)
                
                withAnimation(baseAnimation) {
                    scale = CGSize(width: 1, height: 1)
                }
            }
    }
}

#Preview {
    HealthPointIconView(isDead: false)
}
