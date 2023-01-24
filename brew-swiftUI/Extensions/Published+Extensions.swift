//
//  Published+Extensions.swift
//  brew-swiftUI
//
//  Created by Jennifer Munro-Brown on 29/08/2022.
//

import Foundation
import Combine

typealias ValidationPublisher = AnyPublisher<ValidationResult, Never>

extension Published.Publisher where Value == String {

    func required() -> ValidationPublisher {
        self
            .receive(on: DispatchQueue.main)
            .dropFirst(3)
            .debounce(for: .seconds(Constants.secondsDelay), scheduler: DispatchQueue.main)
            .map {
                $0.isEmpty ? .invalid(.required) : .valid(.required)
            }
            .eraseToAnyPublisher()
    }

    func maxCharacters(_ numberOfCharacters: Int) -> ValidationPublisher {
        self
            .receive(on: DispatchQueue.main)
            .dropFirst()
            .debounce(for: .seconds(Constants.secondsDelay), scheduler: DispatchQueue.main)
            .map {
                $0.count == numberOfCharacters ? .invalid(.maxCharacters(numberOfCharacters)) : .valid(.maxCharacters(numberOfCharacters))
            }
            .eraseToAnyPublisher()
    }
}

