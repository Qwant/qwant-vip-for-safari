//
//  Preferences.swift
//  Qwant VIP for macOS
//
//  Created by Jerome Boursier on 25/01/2023.
//

import Foundation

extension Defaults {
    static let isProtectionActive = DefaultsKey<Bool>("isProtectionActive")
    static let isQwantDefaultSearchEngine = DefaultsKey<Bool>("isQwantDefaultSearchEngine")
    static let protectionLevel = DefaultsKey<ProtectionLevel>("protectionLevel")
    static let hasSeenTutorial = DefaultsKey<Bool>("hasSeenTutorial")
    static let allowlist = DefaultsKey<[String]>("allowlist")
    static let exceptionsJson = DefaultsKey<URL>("exceptions-json")
}

/// Helpers
/// Taken from https://github.com/MateuszKarwat/Napi/blob/master/Napi/Models/Preferences.swift

let AppGroupIdentifier = "76Z29F769J.group.com.qwant.safari.vip"
let Prefs = UserDefaults(suiteName: AppGroupIdentifier)!

class Defaults {
    fileprivate init() {
        Prefs.register(defaults: [
            "isProtectionActive": true,
            "isQwantDefaultSearchEngine": true,
            "hasSeenTutorial": false
        ])
    }
}

class DefaultsKey<ValueType>: Defaults {
    let key: String

    init(_ key: String) {
        self.key = key
    }
}

extension UserDefaults {
    subscript(key: DefaultsKey<Bool>) -> Bool {
        get { bool(forKey: key.key) }
        set { set(newValue, forKey: key.key) }
    }

    subscript(key: DefaultsKey<String?>) -> String? {
        get { string(forKey: key.key) }
        set { set(newValue, forKey: key.key) }
    }

    subscript(key: DefaultsKey<Double>) -> Double {
        get { double(forKey: key.key) }
        set { set(newValue, forKey: key.key) }
    }

    subscript(key: DefaultsKey<URL>) -> URL? {
        get { url(forKey: key.key) }
        set { set(newValue, forKey: key.key) }
    }

    subscript(key: DefaultsKey<ProtectionLevel>) -> ProtectionLevel {
        get { unarchive(key) ?? .standard }
        set { archive(key, newValue) }
    }

    subscript(key: DefaultsKey<[String]>) -> [String] {
        get { stringArray(forKey: key.key) ?? [] }
        set { set(newValue, forKey: key.key) }
    }
}

extension UserDefaults {
    func archive<T: RawRepresentable>(_ key: DefaultsKey<T>, _ value: T?) {
        if let value = value {
            set(value.rawValue, forKey: key.key)
        }
    }

    func unarchive<T: RawRepresentable>(_ key: DefaultsKey<T>) -> T? {
        object(forKey: key.key).flatMap { T(rawValue: $0 as! T.RawValue) }
    }
}
