//
//  ViewController.swift
//  Shared (App)
//
//  Created by Jerome Boursier on 19/07/2022.
//

#if os(iOS)
import UIKit
typealias PlatformViewController = UIViewController
typealias PlatformLabelView = UILabel
typealias PlatformActionView = UIButton
#elseif os(macOS)
import Cocoa
import SafariServices
typealias PlatformViewController = NSViewController
typealias PlatformLabelView = NSTextField
typealias PlatformActionView = NSButton
#endif

let extensionBundleIdentifier = "com.qwant.safari.Qwant-for-Safari.Extension"

class ViewController: PlatformViewController {
    @IBOutlet var extensionStateDescription: PlatformLabelView!

    override func viewDidLoad() {
        super.viewDidLoad()
        doLayout()
    }

    @IBAction func openSettingsTapped(_ sender: PlatformActionView) {
        openSettings()
    }

    func openSettings() {
#if os(iOS)
        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
#elseif os(macOS)
        SFSafariApplication.showPreferencesForExtension(withIdentifier: extensionBundleIdentifier) { _ in
            DispatchQueue.main.async {
                NSApplication.shared.terminate(nil)
            }
        }
#endif
    }

    func doLayout() {
#if os(iOS)
        extensionStateDescription.text = "You can turn on Qwant for Safari’s Safari extension in Settings."
#elseif os(macOS)
        SFSafariExtensionManager.getStateOfSafariExtension(withIdentifier: extensionBundleIdentifier) { state, error in
            let extensionState = ExtensionState(state: state, error: error)
            self.setExtensionState(extensionState)
        }
#endif
    }
}

#if os(macOS)
extension ViewController {
    fileprivate enum ExtensionState {
        case enabled
        case disabled
        case unknown

        init(state: SFSafariExtensionState?, error: Error?) {
            guard let state = state, error == nil else {
                self = .unknown
                return
            }

            self = state.isEnabled ? .enabled : .disabled
        }

        var associatedLabel: String {
            switch self {
                case .enabled:
                    return "Qwant for Safari’s extension is currently on. You can turn it off in Safari Extensions preferences"
                case .disabled:
                    return "Qwant for Safari’s extension is currently off. You can turn it on in Safari Extensions preferences."
                case .unknown:
                    return "You can turn on Qwant for Safari’s extension in Safari Extensions preferences."
            }
        }
    }

    fileprivate func setExtensionState(_ state: ExtensionState) {
        DispatchQueue.main.async {
            self.extensionStateDescription.stringValue = state.associatedLabel
        }
    }
}
#endif
