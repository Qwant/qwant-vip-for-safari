//
//  ContentBlockersJsonBuilder.swift
//  Qwant VIP for macOS
//
//  Created by Jerome Boursier on 03/02/2023.
//

import Foundation

struct ContentBlockersJsonBuilder {
    private init() { }

    static func build() async {
        var tasks = [Task<Category, Never>]()

        for category in Category.allCases {
            let task = Task.detached {
                category.build()
                return category
            }
            tasks.append(task)
        }

        for task in tasks {
            let cat = await task.value
            print("[\(cat.id)] done building")
        }
    }
}
