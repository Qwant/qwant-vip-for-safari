//
//  FlatRoundedButtonStyle.swift
//  Qwant VIP for macOS
//
//  Created by Jerome Boursier on 25/01/2023.
//

import Foundation
import SwiftUI

struct FlatRoundedButtonStyle: ButtonStyle {
    var textColor: Color = .qw.text.primary
    var backgroundColor: Color = .qw.palette.blue
    var cornerRadius: CGFloat = 18

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(textColor)
            .colorInvert()
            .background(backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
    }
}

struct FlatRoundedButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        Button(action: { }) {
            Text("This is a button")
                .padding(.horizontal, 16)
                .padding(.vertical, 6)
        }
        .buttonStyle(FlatRoundedButtonStyle())
    }
}
