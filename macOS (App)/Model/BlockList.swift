//
//  List.swift
//  Qwant VIP for macOS
//
//  Created by Jerome Boursier on 17/01/2023.
//

import Foundation

class BlockList: ObservableObject, Identifiable {
    let id: String
    var name: String
    var category: Category
    var protectionLevel: ProtectionLevel

    @Published var isOn: Bool!

    init(id: String, name: String, category: Category, protectionLevel: ProtectionLevel) {
        self.id = id
        self.name = name
        self.category = category
        self.protectionLevel = protectionLevel
        self.isOn = shouldTheBlockListBeActivated()
        Prefs.set(self.isOn, forKey: "\(id)_is_on")
    }

    func shouldTheBlockListBeActivated() -> Bool {
        guard Prefs[.isProtectionActive] == true else { return false }
        let currentProtectionLevel = Prefs[.protectionLevel]
        switch currentProtectionLevel {
            case .standard: return protectionLevel == .standard
            case .strict: return true
        }
    }
}
