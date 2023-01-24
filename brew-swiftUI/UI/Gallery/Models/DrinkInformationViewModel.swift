//
//  DrinkInformationViewModel.swift
//  brew-swiftUI
//
//  Created by Jennifer Munro-Brown on 22/01/2023.
//

import Combine
import SwiftUI

class DrinkInformationGalleryViewModel: ObservableObject {
    // MARK: - Wrapper Properties
    @Published var selectedIndex: Int = 0

    let configurationCount: Int

    var configurationForSelectedIndex: DrinkInformationConfiguration {
        configuration(forIndex: selectedIndex)
    }

    private let informationItemsConfiguration: [DrinkInformationConfiguration]

    private var timer: AnyCancellable?

    private lazy var timerPublisher: AnyPublisher<Date, Never> = {
        Timer
            .publish(
                every: Constants.timeInterval,
                on: .main,
                in: .common
            )
            .autoconnect()
            .print()
            .eraseToAnyPublisher()
    }()

    // MARK: - Init
    init(configuration: [DrinkInformationConfiguration] = [.cafetiereCoffee, .tea , .instantCoffee]) {
        self.informationItemsConfiguration = configuration
        self.configurationCount = configuration.count
    }

    // MARK: - Public
    func fireTimer() {
        guard timer == nil else { return }
        start()
    }

    func pause() {
        timer?.cancel()
        timer = nil
        print("❌ Information Gallery timer stopped!")

    }

    func configuration(forIndex index: Int) -> DrinkInformationConfiguration {
        if informationItemsConfiguration.indices.contains(index) {
            return informationItemsConfiguration[index]
        } else {
            return .cafetiereCoffee
        }
    }

    // MARK: - Private
    private func start() {
        timer = timerPublisher
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.selectedIndex =  self.selectedIndex < self.configurationCount - 1 ? self.selectedIndex + 1 : 0
                print("🔫 Information Gallery timer fired! selected index \(self.selectedIndex)")
            }
    }
}

private extension DrinkInformationGalleryViewModel {
    enum Constants {
        static var timeInterval: TimeInterval = 10
    }
}
