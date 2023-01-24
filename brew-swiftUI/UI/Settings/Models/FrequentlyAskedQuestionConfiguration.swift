//
//  FrequentlyAskedQuestionConfiguration.swift
//  brew-swiftUI
//
//  Created by Jennifer Munro-Brown on 15/10/2022.
//

import Foundation

struct FrequentlyAskedQuestion: Identifiable, Hashable {
    let id = UUID().uuidString
    let question: String
    let answer: String
}
