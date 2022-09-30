//
//  SafariExtensionHandler.swift
//  macOS (Extension)
//
//  Created by Jerome Boursier on 19/07/2022.
//

import SafariServices

class SafariExtensionHandler: SFSafariExtensionHandler {
    private lazy var searchEngines: [SearchEngine] = {
        let path = Bundle(for: type(of: self)).path(forResource: "preconfigured-search-engines", ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path))
        return try! JSONDecoder().decode([SearchEngine].self, from: data)
    }()

    override func page(_ page: SFSafariPage, willNavigateTo url: URL?) {
        guard UserDefaults.standard.isExtensionActive, let url = url, let qwantURL = qwantURL(from: url) else { return }
        page.getContainingTab { $0.navigate(to: qwantURL) }
    }

    override func popoverViewController() -> SFSafariExtensionViewController {
        macOSExtensionViewController.shared
    }

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
