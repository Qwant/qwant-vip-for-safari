//
//  macOSExtensionViewController.swift
//  Qwant for Safari (iOS)
//
//  Created by Jerome Boursier on 19/07/2022.
//

import SafariServices

class macOSExtensionViewController: SFSafariExtensionViewController {
    @IBOutlet var power: NSButton!
    @IBOutlet var visit: NSButton!
    @IBOutlet var settings: NSButton!

    static let shared = macOSExtensionViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        updateLayout()
    }

    @IBAction func powerButtonClicked(_ sender: NSButton) {
        UserDefaults.standard.isExtensionActive = sender.state == .on
        updateLayout()
    }

    @IBAction func visitQwantComClicked(_ sender: NSButton) {
        NSWorkspace.shared.open(URL(string: "https://www.qwant.com/?client=ext-safari-macos-sb&t=web")!)
        dismiss(self)
    }

    @IBAction func settingsClicked(_ sender: NSButton) {
        NSWorkspace.shared.open(SchemeRoot.safariSettings.url)
    }

    private func updateLayout() {
        power.state = UserDefaults.standard.isExtensionActive ? .on : .off
        power.title = NSLocalizedString("macOS.Extension.Power", comment: "")
        visit.title = NSLocalizedString("macOS.Extension.Visit", comment: "")
        settings.title = NSLocalizedString("macOS.Extension.Settings", comment: "")
    }
}
