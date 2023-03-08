//
//  AddBorder.swift
//  Qwant VIP for macOS
//
//  Created by Jerome Boursier on 08/02/2023.
//

import SwiftUI

extension View {
    func addBorder(color: Color, width: CGFloat, radius: CGFloat) -> some View {
        let shape = RoundedRectangle(cornerRadius: radius)
        return self
            .clipShape(shape)
            .overlay(shape.strokeBorder(color, lineWidth: width))
    }
}
