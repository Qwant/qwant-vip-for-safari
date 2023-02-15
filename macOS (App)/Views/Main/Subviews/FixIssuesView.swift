//
//  FixIssuesView.swift
//  Qwant VIP for macOS
//
//  Created by Jerome Boursier on 25/01/2023.
//

import SwiftUI

struct FixIssuesView: View {
    @Binding var isLoading: Bool
    @Binding var needsSettingsActivation: Bool
    @Binding var isProtectionEnabled: Bool
    @Binding var shouldPresentTutorial: Bool

    var body: some View {
        VStack {
            Text(localized("Main.FixIssues.Description"))
            Button(action: {
                shouldPresentTutorial = true
            }) {
                Text(localized("Main.FixIssues.CTA"))
                    .padding(.horizontal, 16)
                    .padding(.vertical, 6)
            }
        }
        .buttonStyle(FlatRoundedButtonStyle())
        .padding(12)
        .frame(maxWidth: .infinity, alignment: .center)
        .addBorder(color: .orange, width: 1, radius: 12)
        .isHidden(isLoading)
        .isHidden(!needsSettingsActivation)
        .isHidden(!isProtectionEnabled)
    }
}

struct FixIssuesView_Previews: PreviewProvider {
    static var previews: some View {
        FixIssuesView(isLoading: .constant(false),
                      needsSettingsActivation: .constant(true),
                      isProtectionEnabled: .constant(true),
                      shouldPresentTutorial: .constant(false))
    }
}
