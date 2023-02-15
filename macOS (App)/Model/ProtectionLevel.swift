//
//  ProtectionLevel.swift
//  Qwant VIP for macOS
//
//  Created by Jerome Boursier on 25/01/2023.
//

import Foundation

enum ProtectionLevel: String, CaseIterable, Identifiable {
    case standard
    case strict

    var id: String { rawValue }

    var title: String {
        switch self {
            case .standard: return localized("ProtectionLevel.Standard.Title")
            case .strict: return localized("ProtectionLevel.Strict.Title")
        }
    }

    var description: String {
        switch self {
            case .standard: return localized("ProtectionLevel.Standard.Description")
            case .strict: return localized("ProtectionLevel.Strict.Description")
        }
    }

    var isLastInUI: Bool {
        self == .strict
    }
}
