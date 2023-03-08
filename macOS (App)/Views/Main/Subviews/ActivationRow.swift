//
//  ActivationRow.swift
//  Qwant VIP for macOS
//
//  Created by Jerome Boursier on 25/01/2023.
//

import Combine
import SwiftUI

struct ActivationRow: View {
    @Binding var isLoading: Bool
    @Binding var isProtectionEnabled: Bool
    var onToggleChange: ((Bool) -> Void)?

    var body: some View {
        HStack {
            Text(isProtectionEnabled ? "macOS.App.Main.GlobalProtection.Title.Enabled" : "macOS.App.Main.GlobalProtection.Title.Disabled")
                .font(.system(size: 17, weight: .bold))
                .foregroundColor(isProtectionEnabled ? .qw.palette.green : .qw.text.secondary)
                .padding()

            Spacer()

            if isLoading {
                ProgressView(label: { Text("") })
                    .scaleEffect(x: 0.5, y: 0.5, anchor: .center)
                    .padding([.top, .trailing], 10)
            } else {
                Toggle("", isOn: $isProtectionEnabled)
                    .toggleStyle(ColoredToggleStyle(offColor: .qw.text.secondary))
                    .onChange(of: isProtectionEnabled) { newValue in
                        onToggleChange?(newValue)
                    }
                    .padding()
            }
        }
        .rowSkinning()
    }
}

struct ActivationRow_Previews: PreviewProvider {
    static var previews: some View {
        ActivationRow(isLoading: .constant(false),
                      isProtectionEnabled: .constant(true))
    }
}
