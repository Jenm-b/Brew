//
//  Router.swift
//  brew-swiftUI
//
//  Created by Jennifer Munro-Brown on 19/09/2022.
//

import SwiftUI
import Combine

@MainActor
final class Router<Destination: Hashable>: ObservableObject {
    // MARK: - Wrapper Properties
    @Published var navigationPath: [Destination] = []

    // MARK: - Public Methods
    func push(_ destination: Destination) {
        navigationPath.append(destination)
    }

    func pop() {
        navigationPath.removeLast()
    }
}
