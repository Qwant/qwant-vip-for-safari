//
//  ContentBlockersStateProvider.swift
//  Qwant VIP for macOS
//
//  Created by Jerome Boursier on 03/02/2023.
//

import Foundation
import SafariServices

struct ContentBlockersStateProvider {
    private init() { }

    static func categoriesThatNeedsSettingsActivation() async -> [Category] {
        var categoriesThatNeedsActivation = [Category]()
        for category in Category.allCases {
            if await isActivated(category) == nil {
                categoriesThatNeedsActivation.append(category)
            }
        }
        return categoriesThatNeedsActivation
    }

    private static func isActivated(_ category: Category) async -> Category? {
        let state = try? await SFContentBlockerManager.stateOfContentBlocker(withIdentifier: category.associatedBundleIdentifier)
        return (state?.isEnabled ?? true) ? category : nil // Let's not show the UI in case of an error
    }
}
