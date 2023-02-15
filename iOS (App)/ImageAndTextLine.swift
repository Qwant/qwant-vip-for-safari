//
//  ImageAndTextLine.swift
//  Qwant for Safari (iOS)
//
//  Created by Jerome Boursier on 15/02/2023.
//

import SwiftUI

struct ImageAndTextLine: View {
    var imageName: String
    var textKey: String

    var body: some View {
        HStack(spacing: 9) {
            Image(imageName)
            Text(.init(localized(textKey)))
                .foregroundColor(.qw_text_primary)
        }
    }
}

struct ImageAndTextLine_Previews: PreviewProvider {
    static var previews: some View {
        ImageAndTextLine(imageName: "Cog icon", textKey: "iOS.App.Step.1")
    }
}
