//
//  Localization.swift
//  Qwant VIP for macOS
//
//  Created by Jerome Boursier on 01/02/2023.
//

import Foundation

func localized(_ key: String) -> String {
    NSLocalizedString(key, comment: "")
}

func localized(_ key: String, args: [CVarArg]) -> String {
    String(format: localized(key), locale: nil, arguments: args)
}

func localized(_ key: String, arg: CVarArg) -> String {
    localized(key, args: [arg])
}
