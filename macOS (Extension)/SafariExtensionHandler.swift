//
//  SafariExtensionHandler.swift
//  macOS (Extension)
//
//  Created by Jerome Boursier on 19/07/2022.
//

import os.log
import SafariServices
import SwiftUI

class SafariExtensionHandler: SFSafariExtensionHandler {
    // MARK: - Statistics
    override func contentBlocker(withIdentifier contentBlockerIdentifier: String, blockedResourcesWith urls: [URL], on page: SFSafariPage) {
        os_log("[QwantVIP] %{public}@ blocked %{public}@", contentBlockerIdentifier, urls.compactMap({ $0.host }).joined(separator: ", "))
    }

    // MARK: - Popover
    override func popoverViewController() -> SFSafariExtensionViewController {
        SafariExtensionViewController.shared
    }

    override func popoverWillShow(in window: SFSafariWindow) {
        Task {
            let tab = await window.activeTab()
            let page = await tab?.activePage()
            let properties = await page?.properties()
            await MainActor.run {
                SafariExtensionViewController.shared.page = page
                SafariExtensionViewController.shared.url = properties?.url
            }
        }
    }

    override func page(_ page: SFSafariPage, willNavigateTo url: URL?) {
        guard Prefs[.isQwantDefaultSearchEngine], let url = url, let qwantURL = qwantURL(from: url) else { return }
        Task {
            let tab = await page.containingTab()
            await MainActor.run {
                tab.navigate(to: qwantURL)
            }
        }
    }

    private lazy var searchEngines: [SearchEngine] = {
        let path = Bundle(for: type(of: self)).path(forResource: "preconfigured-search-engines", ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path))
        return try! JSONDecoder().decode([SearchEngine].self, from: data)
    }()

    private func qwantURL(from url: URL) -> URL? {
        guard let partner = partnerSearchEngine(from: url), partner.isOriginatingFromApple(url) else {
            return nil
        }
        return URL(string: "https://www.qwant.com/?client=ext-safari-macos-sb&t=web&q=\(partner.userQuery(url))")
    }

    private func partnerSearchEngine(from url: URL) -> SearchEngine? {
        if let host = url.host {
            return searchEngines.first(where: { host.contains($0.engine) })
        }
        return nil
    }
}
