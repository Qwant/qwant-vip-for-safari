//
//  RootView.swift
//  Qwant for Safari (iOS)
//
//  Created by Jerome Boursier on 15/02/2023.
//

import SwiftUI

struct RootView: View {
    var body: some View {
        GeometryReader { geometry in
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {
                    Image("Logo Inline")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: geometry.size.width * (geometry.isLandscape ? 0.4 : 0.7))
                        .padding(.bottom, 40)

                    Text("iOS.App.Header")
                        .font(.system(size: 34, weight: .bold))
                        .foregroundColor(.qw.text.primary)
                        .padding(.bottom, 64)

                    VStack(alignment: .leading, spacing: 20) {
                        ImageAndTextLine(imageName: "Cog icon", text: "iOS.App.Step.1")
                        ImageAndTextLine(imageName: "Safari icon", text: "iOS.App.Step.2")
                        ImageAndTextLine(imageName: "Puzzle icon", text: "iOS.App.Step.3")
                        ImageAndTextLine(imageName: "Toggle icon", text: "iOS.App.Step.4")
                        ImageAndTextLine(imageName: "Tick icon", text: "iOS.App.Step.5")
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 64)

                    VStack(alignment: .leading, spacing: 12) {
                        VStack(alignment: .leading, spacing: 6) {
                            Text("iOS.App.Footer.1")
                                .foregroundColor(.qw.text.secondary)
                                .font(.system(size: 12))
                            Text("iOS.App.Footer.2")
                                .foregroundColor(.qw.text.primary)
                                .font(.system(size: 12))
                        }
                        Text("iOS.App.Footer.3")
                            .foregroundColor(.qw.text.secondary)
                            .font(.system(size: 12))
                    }
                    .padding(.bottom, 48)

                    Spacer()
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity,
                   minHeight: 0, maxHeight: .infinity,
                   alignment: .topLeading)
            .padding()
            .background(Color.qw.palette.background)
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}

private extension GeometryProxy {
    var isLandscape: Bool {
        self.size.width > self.size.height
    }
}
