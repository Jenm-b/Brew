//
//  DrinkStrengthGauge.swift
//  brew-swiftUI
//
//  Created by Jennifer Munro-Brown on 13/01/2023.
//

import SwiftUI

struct DrinkStrengthGauge: View {
    // MARK: - Properties
    let strength: Strength
    let brewerName: String

    private let maxStrengthValue = Double(Strength.allCases.last?.value ?? 10)

    private var currentStrengthValue: Double {
        Double(strength.value)
    }

    private var brewerInitial: String? {
        let initial = brewerName.first?.description.lowercased()
        return initial
    }

    private var imageName: String {
        "\(brewerInitial ?? "asterisk").circle.fill"
    }

    // MARK: - View
    var body: some View {
        Gauge(value: currentStrengthValue, in: 0...maxStrengthValue) {
            Text("\(brewerInitial ?? "asterisk")")
                .textCase(.uppercase)
                .foregroundColor(.label)
                .font(.system(.title, design: .rounded).weight(.semibold))
        }
        .gaugeStyle(.accessoryCircularCapacity)
        .tint(strength.color)
    }
}

struct DrinkStrengthGauge_Previews: PreviewProvider {
    static var previews: some View {
        DrinkStrengthGauge(strength: .medium, brewerName: "Bob")
    }
}
