//
//  HelpSection.swift
//  brew-swiftUI
//
//  Created by Jennifer Munro-Brown on 21/10/2022.
//

import SwiftUI

struct HelpSection: View {
    // MARK: - Wrapped Properties
    @State private var faqExpanded: Bool = false

    // MARK: - Properties
    let helpSectionConfiguration: HelpConfiguration

    // MARK: - Views
    var body: some View {
        Section("Help") {
            faqExpandableList
        }
    }

    private var faqExpandableList: some View {
        DisclosureGroup {
            ForEach(Array(helpSectionConfiguration.faqs.enumerated()), id: \.element) { index, faq in
                let questionNumber = index + 1
                let question = "\(questionNumber). \(faq.question)"
                CommonTextSummary(
                    primaryText: question,
                    secondaryText: faq.answer
                )
            }
        } label: {
            SettingsRow(
                title: "Frequently Asked Questions",
                icon: SFSymbol.questionmark,
                iconTintColor: .orange
            )
        }
        .tint(Color.secondaryLabel)
    }
}
