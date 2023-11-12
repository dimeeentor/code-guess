//
//  ContentView.swift
//  Code Guesser
//
//  Created by Dmytro Honcharenko on 08.11.2023.
//

import SwiftUI

struct MainView: View {
    @FocusState var isTextFieldFocused
    @Bindable private var viewModel = ViewModel()
    @State var onboardingPresented = true

    var body: some View {
        VStack {
            HStack {
                ForEach(0 ..< 5) {
                    HealthPointIconView(isDead: $0 >= viewModel.healthPoints)
                }.animation(.smooth, value: viewModel.healthPoints)
            }

            if viewModel.isCodeShown {
                UserNotificationView(isWon: viewModel.isUserWon, textIfWon: "You've guessed the code!", textIfLost: "Unfortunately. You've lost.")
                    .padding(.top, 30)
            }

            Spacer(minLength: 0)

            HStack(spacing: 12) {
                ForEach(0 ..< viewModel.code.count, id: \.self) { i in
                    let text = viewModel.guessedNumbers.count == 0 ? "?" : String(viewModel.guessedNumbers[i])

                    CodeBlockView(text: text, backgroundColor: viewModel.backgrounds[i])
                }.animation(.smooth, value: viewModel.isUserWon)
            }
            .onAppear { viewModel.generateNewCode() }

            Spacer(minLength: 0)

            if viewModel.isCodeShown {
                PrimaryButtonView(text: "Restart", action: { viewModel.restartGame() })
                    .padding(.bottom, 30)
            }

            ZStack {
                HStack(spacing: 12) {
                    PrimaryTextFieldView(placeholder: "Guess the code...", text: $viewModel.text) {
                        viewModel.checkTheCode(viewModel.text)
                    }
                    .onTapGesture { isTextFieldFocused = true }
                    .focused($isTextFieldFocused)

                    PrimaryButtonView(text: "Guess") {
                        isTextFieldFocused = false
                        viewModel.checkTheCode(viewModel.text)
                    }
                    .opacity(viewModel.stateToggle(using: isTextFieldFocused, newValue: 1, oldValue: 0.25))
                    .animation(.smooth.delay(0.2), value: isTextFieldFocused)
                    .disabled(!isTextFieldFocused)
                }
            }
        }
        .padding(24)
    }
}

#Preview {
    MainView()
}
