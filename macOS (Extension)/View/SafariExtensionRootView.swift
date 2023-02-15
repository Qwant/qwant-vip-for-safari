//
//  SafariExtensionRootView.swift
//  Qwant VIP for macOS
//
//  Created by Jerome Boursier on 02/02/2023.
//

import SwiftUI

struct SafariExtensionRootView: View {
    weak var hostingController: SafariExtensionViewController?
    @State var isInAllowlist = false

    @State private var isProtectionEnabled = Prefs[.isProtectionActive]
    @State private var isQwantDefaultSearchEngine = Prefs[.isQwantDefaultSearchEngine]

    @State var isLoading = true

    var body: some View {
        ZStack {
            if isLoading {
                SafariExtensionLoadingView()
            } else {
                SafariExtensionMainView(isProtectionEnabled: $isProtectionEnabled,
                                        isInAllowlist: $isInAllowlist,
                                        isDefaultSearchEngine: $isQwantDefaultSearchEngine,
                                        hostingController: hostingController)
            }
        }
        .frame(width: 320, height: 360)
        .background(Color.qw_row_background)
        .onAppear {
            isProtectionEnabled = Prefs[.isProtectionActive]
            isQwantDefaultSearchEngine = Prefs[.isQwantDefaultSearchEngine]
            isLoading = true
            DispatchQueue.global().asyncAfter(deadline: .now() + 0.3) {
                isInAllowlist = hostingController?.isInAllowlist ?? false
                isLoading = false
            }
        }
    }
}

struct SafariExtensionRootView_Previews: PreviewProvider {
    static var previews: some View {
        SafariExtensionRootView()
    }
}
