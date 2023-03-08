//
//  NavigationHeaderView.swift
//  Qwant VIP for macOS
//
//  Created by Jerome Boursier on 27/01/2023.
//

import SwiftUI

struct NavigationHeaderView: View {
    var title: LocalizedStringKey?
    @Binding var show: Bool

    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 0) {
                Button {
                    withAnimation {
                        show = false
                    }
                } label: {
                    Image(systemName: "chevron.left")
                }
                .padding()

                Divider()
            }
            Text(title ?? "")
                .font(.title)
        }
    }
}

struct NavigationHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationHeaderView(show: .constant(true))
    }
}
