//
//  QwantVIP_App.swift
//  Qwant for Safari (macOS)
//
//  Created by Jerome Boursier on 14/02/2023.
//

import SwiftUI

@main
struct QwantVIP_App: App {
    var body: some Scene {
        WindowGroup {
            RootView()
                .frame(minWidth: 460, idealWidth: 460, maxWidth: 460,
                       minHeight: 650, idealHeight: 650, maxHeight: 650)
                .handlesExternalEvents(preferring: ["qwantvip"], allowing: ["qwantvip"])
        }
        .windowResizabilityContentSize()
    }
}

extension Scene {
    func windowResizabilityContentSize() -> some Scene {
        if #available(macOS 13.0, *) {
            return windowResizability(.contentSize)
        } else {
            return self
        }
    }
}
