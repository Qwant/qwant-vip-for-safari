//
//  ProtectionLevelRow.swift
//  Qwant VIP for macOS
//
//  Created by Jerome Boursier on 25/01/2023.
//

import SwiftUI

struct ProtectionLevelRow: View {
    var onTap: (() -> Void)?

    var body: some View {
        HStack {
            Text(localized("macOS.App.Main.ProtectionLevel.Title"))
                .font(.system(size: 17, weight: .bold))
                .padding()
            Spacer()
            Text(Prefs[.protectionLevel].title)
                .font(.system(size: 17, weight: .regular))
                .foregroundColor(.qw_text_secondary)
            Image(systemName: "chevron.right")
                .foregroundColor(.qw_text_secondary)
                .padding(.trailing)
        }
        .rowSkinning()
        .onTapGesture {
            withAnimation {
                onTap?()
            }
        }
    }
}

struct ProtectionLevelRow_Previews: PreviewProvider {
    static var previews: some View {
        ProtectionLevelRow()
    }
}
