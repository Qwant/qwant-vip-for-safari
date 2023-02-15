//
//  LogoView.swift
//  Qwant VIP for macOS
//
//  Created by Jerome Boursier on 25/01/2023.
//

import SwiftUI

struct LogoView: View {
    var body: some View {
        Image("Qwant VIP inline")
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, 32)
    }
}

struct LogoView_Previews: PreviewProvider {
    static var previews: some View {
        LogoView()
    }
}
