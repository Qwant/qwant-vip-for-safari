//
//  ViewSkinningViewBuilder.swift
//  Qwant VIP for macOS
//
//  Created by Jerome Boursier on 08/02/2023.
//

import SwiftUI

extension View {
    @ViewBuilder func viewSkinning() -> some View {
        self
            .background(Color.qw_background)
    }
}
