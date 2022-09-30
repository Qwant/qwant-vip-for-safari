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
        static let extensionCanBeTurnedOffUserDefaultsKey = "extensionCanBeTurnedOff"
    }

    var hasSeenItCanBeTurnedOff: Bool {
        get { bool(forKey: Constants.extensionCanBeTurnedOffUserDefaultsKey) }
        set { setValue(newValue, forKey: Constants.extensionCanBeTurnedOffUserDefaultsKey) }
    }

    var isExtensionActive: Bool {
        get { !hasSeenItCanBeTurnedOff || bool(forKey: Constants.extensionPowerButtonUserDefaultsKey) }
        set {
            setValue(newValue, forKey: Constants.extensionPowerButtonUserDefaultsKey)
            setValue(true, forKey: Constants.extensionCanBeTurnedOffUserDefaultsKey)
        }
    }
}

extension URL {
    func valueFor(queryParam: String) -> String? {
        guard let components = URLComponents(url: self, resolvingAgainstBaseURL: false) else {
            return nil
        }

        return components
            .queryItems?
            .first { $0.name == queryParam }?
            .value?
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
}
