//
//  ContentBlockersReloader.swift
//  Qwant VIP for macOS
//
//  Created by Jerome Boursier on 03/02/2023.
//

import Foundation
import SafariServices

struct ContentBlockersReloader {
    private init() { }

    private static let MAX_RETRIES = 1

    static func reloadAll() async {
        for category in Category.allCases {
            await reload(category)
        }
    }

    private static func reload(_ category: Category) async {
        await reload(category, retryCount: 0)
    }

    private static func reload(_ category: Category, retryCount: Int) async {
        do {
            guard retryCount <= MAX_RETRIES else { return }
            print("[\(category.id)] reloaded")
            try await SFContentBlockerManager.reloadContentBlocker(withIdentifier: category.associatedBundleIdentifier)
        } catch _ {
            print("[\(category.id)] failed to reload, retrying")
            await reload(category, retryCount: retryCount + 1)
        }
    }
}
