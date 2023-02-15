//
//  ContentBlockerRequestHandler.swift
//  Qwant VIP for macOS
//
//  Created by Jerome Boursier on 16/01/2023.
//

import Foundation
import os.log
import SwiftyJSON

class ContentBlockerRequestHandler: NSObject, NSExtensionRequestHandling {
    func beginRequest(with context: NSExtensionContext) {
        let targetName = Bundle.main.object(forInfoDictionaryKey: "ContentBlockerCategory") as? String ?? ""
        let jsonURL = Prefs.url(forKey: targetName + "-json")

        let jsonData = try? Data(contentsOf: jsonURL!)
        let jsonCount = try? JSON(data: jsonData ?? Data()).arrayValue.count

        let attachment = NSItemProvider(contentsOf: jsonURL)!
        let item = NSExtensionItem()
        item.attachments = [attachment]
        context.completeRequest(returningItems: [item]) { finished in
            os_log("[QwantVIP] Content blocker %{public}@ completed request with %{public}d entries with %{public}@", targetName, jsonCount ?? 0, finished ? "true" : "false")
        }
    }
}
