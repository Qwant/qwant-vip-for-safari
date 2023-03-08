//
//  ImageAndTextLine.swift
//  Qwant for Safari (iOS)
//
//  Created by Jerome Boursier on 15/02/2023.
//

import SwiftUI

struct ImageAndTextLine: View {
    var imageName: String
    var text: LocalizedStringKey

    var body: some View {
        HStack(spacing: 9) {
            Image(imageName)
            Text(text)
                .foregroundColor(.qw.text.primary)
        }
    }
}

struct ImageAndTextLine_Previews: PreviewProvider {
    static var previews: some View {
        ImageAndTextLine(imageName: "Cog icon", text: "iOS.App.Step.1")
    }
}
