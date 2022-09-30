//
//  iOSAppViewController.swift
//  Shared (App)
//
//  Created by Jerome Boursier on 19/07/2022.
//

import UIKit

class iOSAppViewController: UIViewController {
    @IBOutlet var header: UILabel!
    @IBOutlet var step1: UILabel!
    @IBOutlet var step2: UILabel!
    @IBOutlet var step3: UILabel!
    @IBOutlet var step4: UILabel!
    @IBOutlet var step5: UILabel!
    @IBOutlet var footer1: UILabel!
    @IBOutlet var footer2: UILabel!
    @IBOutlet var footer3: UILabel!
    @IBOutlet var button: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        doLayout()
    }

    @IBAction func openSettingsTapped(_ sender: UIButton) {
        openSettings()
    }

    func openSettings() {
        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
    }

    func doLayout() {
        header.text = NSLocalizedString("iOS.App.Header", comment: "")
        step1.attributedText = NSLocalizedString("iOS.App.Step.1", comment: "").makeDoubleStarsTagsBoldAndRemoveThem
        step2.attributedText = NSLocalizedString("iOS.App.Step.2", comment: "").makeDoubleStarsTagsBoldAndRemoveThem
        step3.attributedText = NSLocalizedString("iOS.App.Step.3", comment: "").makeDoubleStarsTagsBoldAndRemoveThem
        step4.attributedText = NSLocalizedString("iOS.App.Step.4", comment: "").makeDoubleStarsTagsBoldAndRemoveThem
        step5.attributedText = NSLocalizedString("iOS.App.Step.5", comment: "").makeDoubleStarsTagsBoldAndRemoveThem
        footer1.text = NSLocalizedString("iOS.App.Footer.1", comment: "")
        footer2.text = NSLocalizedString("iOS.App.Footer.2", comment: "")
        footer3.text = NSLocalizedString("iOS.App.Footer.3", comment: "")
        button.setTitle(NSLocalizedString("iOS.App.StartButton", comment: ""), for: .normal)
    }
}

extension String {
    var makeDoubleStarsTagsBoldAndRemoveThem: NSAttributedString? {
        let regex = try! NSRegularExpression(pattern: "\\*\\*(.*?)\\*\\*", options: [])
        let results = regex.matches(in: self, range: NSRange(self.startIndex..., in: self))

        let cleanedString = self.replacingOccurrences(of: "**", with: "")
        let attributedStr = NSMutableAttributedString(string: cleanedString)
        for i in 0 ..< results.count {
            let result = results[i]
            let cleanedRange = NSRange(location: result.range.location - (4 * i), length: result.range.length - 4)
            attributedStr.addAttributes([.font: UIFont.systemFont(ofSize: 17, weight: .bold)], range: cleanedRange)
        }
        return attributedStr
    }
}
