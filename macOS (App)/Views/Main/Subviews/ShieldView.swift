//
//  ShieldView.swift
//  Qwant VIP for macOS
//
//  Created by Jerome Boursier on 25/01/2023.
//

import SwiftUI

struct ShieldView: View {
    enum State {
        case active
        case inactive
        case paused

        var image: Image {
            switch self {
                case .active: return Image("Green shield")
                case .inactive: return Image("Grey shield")
                case .paused: return Image("Red shield")
            }
        }
    }

    var shieldState: State

    var body: some View {
        shieldState.image
            .scaleEffect(1.3)
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.bottom, 32)
    }
}

struct ShieldView_Previews: PreviewProvider {
    static var previews: some View {
        ShieldView(shieldState: .active)
    }
}
