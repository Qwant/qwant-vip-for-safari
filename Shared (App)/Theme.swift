//
//  Theme.swift
//  Qwant VIP for macOS
//
//  Created by Jerome Boursier on 03/02/2023.
//

import SwiftUI

extension Color {
    enum qw {
        enum text {
            static let primary = Color("qw_text_primary")
            static let secondary = Color("qw_text_secondary")
        }

        enum palette {
            static let blue = Color("qw_blue")
            static let green = Color("qw_green")
            static let red = Color("qw_red")

            static let background = Color("qw_background")
            static let row = Color("qw_row_background")
        }
    }
}

prefix func ! (value: Binding<Bool>) -> Binding<Bool> {
    Binding<Bool>(
        get: { !value.wrappedValue },
        set: { value.wrappedValue = !$0 }
    )
}
