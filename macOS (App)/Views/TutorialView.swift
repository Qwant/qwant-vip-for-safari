//
//  TutorialView.swift
//  Qwant VIP for macOS
//
//  Created by Jerome Boursier on 18/01/2023.
//

import SafariServices
import SwiftUI

struct TutorialView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var category: Category?

    var body: some View {
        HStack(alignment: .top) {
            VStack(spacing: 0) {
                LogoView()
                Text("macOS.App.Tutorial.Title")
                    .font(.system(size: 34, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 38)
                VStack(alignment: .leading, spacing: 20) {
                    HStack {
                        Image("Safari icon")
                        Text("macOS.App.Tutorial.Step.1")
                            .font(.system(size: 15, weight: .regular))
                        Button {
                            let category = category ?? .ads
                            SFSafariApplication.showPreferencesForExtension(withIdentifier: category.associatedBundleIdentifier) { _ in
                                dismiss()
                            }
                        } label: {
                            Text("macOS.App.Tutorial.Step.1.CTA")
                                .padding(.horizontal, 16)
                                .padding(.vertical, 6)
                        }
                        .buttonStyle(FlatRoundedButtonStyle())
                    }
                    HStack {
                        Image("Toggle icon")
                        Text("macOS.App.Tutorial.Step.2")
                            .font(.system(size: 15, weight: .regular))
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark")
            }
            .clipShape(Circle())
        }
        .padding()
        .padding(.bottom, 20)
        .frame(width: 500, height: 340)
    }
}

struct TutorialView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialView(category: .constant(.ads))
    }
}
