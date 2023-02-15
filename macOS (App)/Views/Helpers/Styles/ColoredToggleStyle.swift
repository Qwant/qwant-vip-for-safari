//
//  ColoredToggleStyle.swift
//  Qwant VIP for macOS
//
//  Created by Jerome Boursier on 07/02/2023.
//

import Foundation
import SwiftUI

struct ColoredToggleStyle: ToggleStyle {
    var onColor: Color = .qw_green
    var offColor: Color = .qw_red

    @State private var offsetX: CGFloat?
    @State private var fillColor: Color?

    func makeBody(configuration: Self.Configuration) -> some View {
        HStack {
            configuration.label
            Button {
                withAnimation(.easeOut) {
                    configuration.isOn.toggle()
                    offsetX = configuration.isOn ? 7.5 : -7.5
                    fillColor = configuration.isOn ? onColor : offColor
                }
            } label: {
                RoundedRectangle(cornerRadius: 16, style: .circular)
                    .fill(fillColor ?? (configuration.isOn ? onColor : offColor))
                    .frame(width: 37, height: 22)
                    .overlay(
                        Circle()
                            .fill(.white)
                            .shadow(radius: 1, x: 0, y: 1)
                            .padding(1)
                            .offset(x: offsetX ?? (configuration.isOn ? 7.5 : -7.5)))
            }
            .buttonStyle(.link)
        }
    }
}

struct ColoredToggleStyle_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Toggle("This is a toggle", isOn: .constant(false))
                .toggleStyle(ColoredToggleStyle())

            Toggle("This is a toggle", isOn: .constant(false))
                .toggleStyle(.switch)
        }
    }
}
