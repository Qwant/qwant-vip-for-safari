//
//  ProtectionLevelView.swift
//  Qwant VIP for macOS
//
//  Created by Jerome Boursier on 23/01/2023.
//

import SwiftUI

struct ProtectionLevelView: View {
    @State var selectedLevel: ProtectionLevel
    @Binding var show: Bool
    @Binding var reload: Bool

    var body: some View {
        VStack(alignment: .leading) {
            NavigationHeaderView(title: localized("macOS.App.ProtectionLevel.Title"), show: $show)

            VStack(alignment: .leading) {
                ForEach(ProtectionLevel.allCases) { level in
                    LevelRow(level: level, selectedLevel: $selectedLevel)
                }
            }
            .padding()
            .background(Color.qw_row_background)
            .cornerRadius(10)
            .padding()

            Spacer()
        }
        .viewSkinning()
        .onDisappear {
            let initialValue = Prefs[.protectionLevel]
            Prefs[.protectionLevel] = selectedLevel
            reload = initialValue != selectedLevel
        }
    }
}

struct ProtectionLevelView_Previews: PreviewProvider {
    static var previews: some View {
        ProtectionLevelView(selectedLevel: .standard,
                            show: .constant(true),
                            reload: .constant(false))
    }
}

// Removes background from List in SwiftUI
extension NSTableView {
    override open func viewDidMoveToWindow() {
        super.viewDidMoveToWindow()

        backgroundColor = NSColor.clear
        if let esv = enclosingScrollView {
            esv.drawsBackground = false
        }
    }
}
