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
            NavigationHeaderView(title: "macOS.App.Allowlist.Title", show: $show)

            VStack(alignment: .leading) {
                Text("macOS.App.Allowlist.Description.1")
                Text("macOS.App.Allowlist.Description.2")
                Text("macOS.App.Allowlist.Description.3")
                    .font(.caption)
                    .foregroundColor(.qw.text.secondary)
            }
            .padding()

            TextEditor(text: $allowlist)
                .border(Color.qw.text.secondary)
                .font(.monospaced(.system(size: 15))())
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
