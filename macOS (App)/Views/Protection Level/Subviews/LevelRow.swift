//
//  LevelRow.swift
//  Qwant VIP for macOS
//
//  Created by Jerome Boursier on 27/01/2023.
//

import SwiftUI

struct LevelRow: View {
    let level: ProtectionLevel
    @Binding var selectedLevel: ProtectionLevel

    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(level.title)
                        .font(.system(size: 17))
                    Text(level.description)
                        .foregroundColor(.qw.text.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
                Spacer()
                if level == selectedLevel {
                    Image("Check icon")
                }
            }
            if !level.isLastInUI {
                Divider()
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            selectedLevel = level
        }
    }
}

struct LevelRow_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            LevelRow(level: .standard, selectedLevel: .constant(.standard))
            LevelRow(level: .standard, selectedLevel: .constant(.strict))
            Divider()
            LevelRow(level: .strict, selectedLevel: .constant(.strict))
            LevelRow(level: .strict, selectedLevel: .constant(.standard))
            Divider()
        }
    }
}
