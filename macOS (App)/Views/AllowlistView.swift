//
//  AllowlistView.swift
//  Qwant VIP for macOS
//
//  Created by Jerome Boursier on 25/01/2023.
//

import SwiftUI

struct AllowlistView: View {
    @Binding private var show: Bool
    @Binding private var reload: Bool
    @State private var allowlist: String

    init(show: Binding<Bool>, reload: Binding<Bool>) {
        self._show = show
        self._reload = reload
        self.allowlist = ContentBlockersExceptions.allowlistString
    }

    var body: some View {
        VStack(alignment: .leading) {
            NavigationHeaderView(title: localized("Allowlist.Title"), show: $show)

            VStack(alignment: .leading) {
                Text(.init(localized("Allowlist.Description.1")))
                Text(localized("Allowlist.Description.2"))
                Text(.init(localized("Allowlist.Description.3")))
                    .font(.caption)
                    .foregroundColor(.qw_text_secondary)
            }
            .padding()

            TextArea(text: $allowlist)
                .border(Color.qw_text_secondary)
                .padding(.horizontal)

            Spacer()
        }
        .viewSkinning()
        .onDisappear {
            if ContentBlockersExceptions.allowlistString != allowlist {
                let newList = allowlist
                    .split(separator: "\n")
                    .map { String($0) }
                ContentBlockersExceptions.reset(with: newList)
                reload = true
            }
        }
    }
}

struct AllowlistView_Previews: PreviewProvider {
    static var previews: some View {
        AllowlistView(show: .constant(true),
                      reload: .constant(false))
    }
}
