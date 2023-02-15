//
//  Category.swift
//  Qwant VIP for macOS
//
//  Created by Jerome Boursier on 17/01/2023.
//

import Foundation
import SwiftyJSON

enum Category: String, CaseIterable, Identifiable {
    case ads
    case privacy
    case social
    case annoyances
    case security
    case other
    case language

    var id: String { rawValue }

    private var path: String { "\(rawValue)/" }

    private var url: URL { FileManager.default
            .containerURL(forSecurityApplicationGroupIdentifier: AppGroupIdentifier)!
            .appendingPathComponent(id)
            .appendingPathExtension("json")
    }

    /// Is it needed?
    private var associatedTarget: String {
        switch self {
            case .ads: return "Ads Blocker Extension"
            case .privacy: return "Privacy Blocker Extension"
            case .social: return "Social Blocker Extension"
            case .annoyances: return "Annoyances Blocker Extension"
            case .security: return "Security Blocker Extension"
            case .other: return "Other Blocker Extension"
            case .language: return "Language Blocker Extension"
        }
    }

    var associatedBundleIdentifier: String {
        let target = associatedTarget.replacingOccurrences(of: " ", with: "-")
        return "com.qwant.safari.Qwant-for-Safari.\(target)"
    }

    /// Builds the category by doing the following steps:
    ///
    /// 1. Writes all the exceptions (safelist / allowlist) onto a brand new JSON
    /// 2. Iterates through all files within the generated lists
    ///     a. If the file is "on", it appends its content onto the JSON
    ///     b. If the file is "off", it just skips it
    /// 3. Ensures the final JSON is not empty (it should contains at least the exceptions)
    /// 4. Writes this JSON onto the predefined Category's URL
    /// 5. Writes the path of this URL onto the shared user defaults.
    ///
    func build() {
        let exceptionsURL = Prefs[.exceptionsJson]!
        var finalJSON = try! JSON(data: Data(contentsOf: exceptionsURL))

        do {
            let files = try FileManager.default.contentsOfDirectory(atPath: Bundle.main.resourcePath! + "/" + path)
            for file in files {
                let fileName = String(file.split(separator: ".").first!)
                guard Prefs.bool(forKey: "\(fileName)_is_on") else { continue }
                let data = Bundle.main.url(forResource: path + file, withExtension: nil)!
                let json = try JSON(data: Data(contentsOf: data))
                finalJSON = JSON(json.arrayValue + finalJSON.arrayValue)
            }

            assert(!finalJSON.arrayValue.isEmpty)

            print("[\(id)] Wrote \(finalJSON.arrayValue.count) rules")
            try finalJSON.rawData().write(to: url, options: .atomic)
            Prefs.set(url, forKey: id + "-json")
        } catch let error as NSError {
            print(error)
        }
    }
}
