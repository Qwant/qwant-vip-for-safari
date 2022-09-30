//
//  macOSAppViewController.swift
//  Qwant for Safari
//
//  Created by Jerome Boursier on 29/09/2022.
//

import Cocoa
import SafariServices

class macOSAppViewController: NSViewController {
    @IBOutlet var header: NSTextField!
    @IBOutlet var button: NSButton!
    @IBOutlet var visit: NSTextField!
    @IBOutlet var link: LinkTextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        doLayout()
    }

    @IBAction func openSettingsClicked(_ sender: NSButton) {
        sender.state = .on
        SFSafariApplication.showPreferencesForExtension(withIdentifier: extensionBundleIdentifier)
    }

    @IBAction func visitQwantComClicked(_ sender: NSClickGestureRecognizer) {
        NSWorkspace.shared.open(URL(string: "https://www.qwant.com/?client=ext-safari-macos-sb&t=web")!)
    }

    func doLayout() {
        header.stringValue = NSLocalizedString("macOS.App.Header", comment: "")
        button.title = NSLocalizedString("macOS.App.SettingsButton", comment: "")
        visit.stringValue = NSLocalizedString("macOS.App.Visit", comment: "")
    }
}

class LinkTextField: NSTextField {
    override func resetCursorRects() {
        addCursorRect(bounds, cursor: .pointingHand)
    }
}
