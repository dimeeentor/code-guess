//
//  ViewModel.swift
//  Code Guesser
//
//  Created by Dmytro Honcharenko on 09.11.2023.
//

import Foundation
import Observation
import SwiftUI

struct DefaultStyles {
    let padding: CGFloat = 12
    let lineWidth: CGFloat = 0.5
    let cornerRadius: CGFloat = 12.0
    let foregroundOpacity: CGFloat = 0.8

    let primaryShadowColor: Color = .primary.opacity(0.2)
    let primaryShadowRadius: CGFloat = 0.5

    let secondaryShadowColor: Color = .secondary.opacity(0.2)
    let secondaryShadowRadius: CGFloat = 1
}

@Observable final class ViewModel {
    var text = ""
    var code: [Int] = []
    var healthPoints = 5
    var isUserWon = false
    var isCodeShown = false
    var guessedNumbers: [Int] = []
    var backgrounds: [CodeBlock] = Array(repeating: .incorrect, count: 4)

    func generateNewCode() {
        for _ in 0 ... 3 { code.append(Int.random(in: 0 ... 9)) }
    }

    func checkTheCode(_ code: String) {
        if code.count == 4 {
            let codeToCheck = text.split(separator: "").map { Int($0)! }

            if !guessedNumbers.isEmpty { guessedNumbers.removeAll(keepingCapacity: true) }

            for (i, el) in codeToCheck.enumerated() {
                if el == self.code[i] {
                    backgrounds[i] = .correct
                } else if self.code.contains(el) {
                    backgrounds[i] = .wrongPlace
                } else {
                    backgrounds[i] = .incorrect
                }

                guessedNumbers.insert(el, at: i)
            }

            if guessedNumbers.elementsEqual(self.code) {
                isUserWon = true
                isCodeShown = true
            } else if healthPoints == 1 {
                isCodeShown = true
                for i in 0 ..< backgrounds.count { backgrounds[i] = .incorrect }
                guessedNumbers = self.code
                healthPoints = 0
            } else { healthPoints -= 1 }
        }

        text = ""
    }

    func restartGame() {
        text = ""
        healthPoints = 5
        isUserWon = false
        isCodeShown = false
        code.removeAll(keepingCapacity: true)
        guessedNumbers.removeAll(keepingCapacity: true)
        for i in 0 ..< backgrounds.count { backgrounds[i] = .incorrect }
        generateNewCode()
    }

    func stateToggle(using bool: Bool, newValue: CGFloat, oldValue: CGFloat = 0) -> CGFloat {
        bool ? newValue : oldValue
    }
}
