//
//  QwantForSafariViewController.swift
//  Qwant for Safari (iOS)
//
//  Created by Jerome Boursier on 19/07/2022.
//

import SafariServices

let extensionBundleIdentifier = "com.qwant.safari.macos.Qwant-for-Safari.Extension"

class QwantForSafariViewController: SFSafariExtensionViewController {
    @IBOutlet var extensionPowerButton: NSButton!

    static let shared = QwantForSafariViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        updateLayout()
    }

    @IBAction func extensionPowerButtonTapped(_ sender: NSButton) {
        UserDefaults.standard.isExtensionActive = sender.state == .off
        updateLayout()
    }

    private func updateLayout() {
        extensionPowerButton.state = UserDefaults.standard.isExtensionActive ? .off : .on
        extensionPowerButton.title = UserDefaults.standard.isExtensionActive ? "Stop using Qwant as default search engine" : "Make Qwant your default search engine"
    }
}
