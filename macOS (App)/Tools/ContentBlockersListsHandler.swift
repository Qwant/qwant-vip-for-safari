//
//  ContentBlockersListsHandler.swift
//  Qwant VIP for macOS
//
//  Created by Jerome Boursier on 03/02/2023.
//

import Foundation

struct ContentBlockersListsHandler {
    private init() { }

    static func computeBlockLists() {
        for category in Category.allCases {
            let file = Bundle.main.url(forResource: category.id, withExtension: "txt")!
            let content = try! String(contentsOf: file, encoding: .utf8)
                .split(separator: "\n").map { // Split file per line
                    $0.split(separator: ";").map { // Split line per comma
                        String(describing: $0)
                    }
                }
            for line in content {
                if let protectionLevel = ProtectionLevel(rawValue: line[1]) {
                    _ = BlockList(id: line[0], name: line[3], category: category, protectionLevel: protectionLevel)
                    // In the past we needed to hold a list of blocklist, but now we just keep
                    // the object init to write in the user defaults the status of the current blocklist
                    // This choice is particulary wrong. But meh.
                }
            }
        }
    }
}
