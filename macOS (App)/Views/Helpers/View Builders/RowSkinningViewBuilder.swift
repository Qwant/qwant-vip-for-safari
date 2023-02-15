//
//  RowSkinningViewBuilder.swift
//  Qwant VIP for macOS
//
//  Created by Jerome Boursier on 08/02/2023.
//

import SwiftUI

extension View {
    @ViewBuilder func rowSkinning() -> some View {
        self
            .contentShape(Rectangle())
            .frame(height: 44, alignment: .leading)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.qw_row_background)
            .cornerRadius(10)
            .padding(.bottom, 16)
    }
}
