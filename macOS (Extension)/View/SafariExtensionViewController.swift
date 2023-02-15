//
//  SafariExtensionViewController.swift
//  Safari Extension
//
//  Created by Jerome Boursier on 01/02/2023.
//

import Foundation
import SafariServices
import SwiftUI

class SafariExtensionViewController: SFSafariExtensionViewController {
    static let shared = SafariExtensionViewController()

    var page: SFSafariPage?
    var url: URL?

    var isInAllowlist: Bool {
        guard let host = url?.host else { return false }
        return ContentBlockersExceptions.hasException(for: host)
    }

    override func loadView() {
        view = NSView(frame: NSRect(x: 0.0, y: 0.0, width: 320, height: 360))

        var root = SafariExtensionRootView()
        root.hostingController = self
        let safariView = NSHostingController(rootView: root).view
        safariView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(safariView)

        NSLayoutConstraint.activate([
            safariView.topAnchor.constraint(equalTo: view.topAnchor),
            safariView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            safariView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            safariView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    func onToggleChange() async {
        guard let url = url, let host = url.host else { return }

        ContentBlockersExceptions.handle(domain: host)
        ContentBlockersListsHandler.computeBlockLists()
        await ContentBlockersJsonBuilder.build()
        await ContentBlockersReloader.reloadAll()
        page?.reload()
        dismiss(self)
    }

    func onSearchEngineToggleChange() {
        Prefs[.isQwantDefaultSearchEngine].toggle()
    }
}
