//
//  RowSkinning.swift
//  Qwant VIP for macOS
//
//  Created by Jerome Boursier on 08/02/2023.
//

import SwiftUI

extension View {
    func rowSkinning() -> some View {
        self
            .contentShape(Rectangle())
            .frame(height: 44, alignment: .leading)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.qw.palette.row)
            .cornerRadius(10)
            .padding(.bottom, 16)
    }
}
