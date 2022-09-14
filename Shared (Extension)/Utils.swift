//
//  Utils.swift
//  Qwant for Safari (iOS)
//
//  Created by Jerome Boursier on 19/07/2022.
//

import Foundation

extension UserDefaults {
    private struct Constants {
        static let extensionPowerButtonUserDefaultsKey = "extensionPowerButton"
    }

    var isExtensionActive: Bool {
        get { bool(forKey: Constants.extensionPowerButtonUserDefaultsKey) }
        set { setValue(newValue, forKey: Constants.extensionPowerButtonUserDefaultsKey) }
    }
}

extension URL {
    func valueFor(queryParam: String) -> String? {
        guard let components = URLComponents(url: self, resolvingAgainstBaseURL: false) else {
            return nil
        }

        return components.queryItems?.first { $0.name == queryParam }?.value
    }
}
