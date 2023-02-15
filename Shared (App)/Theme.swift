//
//  Theme.swift
//  Qwant VIP for macOS
//
//  Created by Jerome Boursier on 03/02/2023.
//

import SwiftUI

extension Color {
    static let qw_background = Color("qw_background")
    static let qw_row_background = Color("qw_row_background")

    static let qw_blue = Color("qw_blue")
    static let qw_green = Color("qw_green")
    static let qw_red = Color("qw_red")

    static let qw_text_primary = Color("qw_text_primary")
    static let qw_text_secondary = Color("qw_text_secondary")
}

prefix func ! (value: Binding<Bool>) -> Binding<Bool> {
    Binding<Bool>(
        get: { !value.wrappedValue },
        set: { value.wrappedValue = !$0 }
    )
}
