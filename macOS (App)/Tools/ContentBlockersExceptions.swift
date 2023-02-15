//
//  ContentBlockersExceptions.swift
//  Qwant VIP for macOS
//
//  Created by Jerome Boursier on 17/01/2023.
//

import ContentBlockerConverter
import Foundation
import SwiftyJSON

struct ContentBlockersExceptions {
    private init() { }

    static func hasException(for domain: String) -> Bool {
        let domain = domain.sanitizedDomain
        return Prefs[.allowlist].contains(domain)
    }

    static func handle(domain: String) {
        let domain = domain.sanitizedDomain
        if hasException(for: domain) {
            remove(domain)
        } else {
            add(domain)
        }
    }

    static func reset(with list: [String]) {
        Prefs[.allowlist] = list
        build()
    }

    static var allowlistString: String {
        Prefs[.allowlist].joined(separator: "\n")
    }

    private static func add(_ domain: String) {
        Prefs[.allowlist] += [domain]
        build()
    }

    private static func remove(_ domain: String) {
        Prefs[.allowlist].removeAll(where: { $0 == domain })
        build()
    }

    static func build() {
        do {
            let prefix = "@@||"
            let suffix = "^$document"

            let arr = ContentBlockerConverter().convertArray(
                rules: Prefs[.allowlist].map { prefix + $0 + suffix },
                safariVersion: .safari16,
                optimize: true,
                advancedBlocking: true,
                advancedBlockingFormat: .json
            )

            let allowlistJSON = try JSON(data: arr.converted.data(using: .utf8)!)
            let json = try JSON.safelistJSON.merged(with: allowlistJSON)

            let jsonMergeURL = FileManager.default
                .containerURL(forSecurityApplicationGroupIdentifier: AppGroupIdentifier)!
                .appendingPathComponent("exceptions")
                .appendingPathExtension("json")

            try json.rawData().write(to: jsonMergeURL, options: .atomic)
            Prefs[.exceptionsJson] = jsonMergeURL
        } catch let error as NSError {
            print(error)
        }
    }
}

private extension String {
    var sanitizedDomain: String {
        var domain = self.trimmingCharacters(in: .whitespacesAndNewlines)
        if domain.starts(with: "www.") {
            domain.removeFirst(4)
        }
        return domain
    }
}

private extension JSON {
    static var safelistJSON: JSON {
        let safelist = Bundle.main.url(forResource: "/allow/QwantSafelist", withExtension: "json")!
        return try! JSON(data: Data(contentsOf: safelist))
    }
}
