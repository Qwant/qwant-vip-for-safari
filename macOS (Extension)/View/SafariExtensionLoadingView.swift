//
//  SafariExtensionLoadingView.swift
//  Qwant VIP for macOS
//
//  Created by Jerome Boursier on 06/02/2023.
//

import SwiftUI

struct SafariExtensionLoadingView: View {
    var body: some View {
        VStack {
            LogoView()

            Spacer()

            ProgressView {
                Text("macOS.Extension.Loading")
                    .foregroundColor(.qw.text.secondary)
            }

            Spacer()
        }
        .padding()
    }
}

struct SafariExtensionLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        SafariExtensionLoadingView()
    }
}
