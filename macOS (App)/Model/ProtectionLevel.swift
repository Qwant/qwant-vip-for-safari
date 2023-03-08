//
//  ProtectionLevel.swift
//  Qwant VIP for macOS
//
//  Created by Jerome Boursier on 25/01/2023.
//

import SwiftUI

enum ProtectionLevel: String, CaseIterable, Identifiable {
    case standard
    case strict

    var id: String { rawValue }

    var title: LocalizedStringKey {
        switch self {
            case .standard: return "macOS.App.ProtectionLevel.Standard.Title"
            case .strict: return "macOS.App.ProtectionLevel.Strict.Title"
        }
    }

    var description: LocalizedStringKey {
        switch self {
            case .standard: return "macOS.App.ProtectionLevel.Standard.Description"
            case .strict: return "macOS.App.ProtectionLevel.Strict.Description"
        }
    }

    var isLastInUI: Bool {
        self == .strict
    }
}
