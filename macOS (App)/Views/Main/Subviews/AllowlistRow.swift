//
//  AllowlistRow.swift
//  Qwant VIP for macOS
//
//  Created by Jerome Boursier on 25/01/2023.
//

import SwiftUI

struct AllowlistRow: View {
    var onTap: (() -> Void)?

    var body: some View {
        VStack(spacing: -8) {
            HStack {
                Text(localized("macOS.App.Main.Allowlist.Title"))
                    .font(.system(size: 17, weight: .bold))
                    .padding()
                Spacer()
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
            Text(localized("macOS.App.Main.Allowlist.Footer"))
                .font(.system(size: 15))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
                .foregroundColor(.qw_text_secondary)
        }
    }
}

struct AllowlistRow_Previews: PreviewProvider {
    static var previews: some View {
        AllowlistRow()
    }
}
