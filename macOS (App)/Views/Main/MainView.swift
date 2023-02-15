//
//  MainView.swift
//  Qwant VIP for macOS
//
//  Created by Jerome Boursier on 17/01/2023.
//

import SwiftUI

struct MainView: View {
    @Binding var showLevel: Bool
    @Binding var showAllowlist: Bool
    @Binding var showTutorial: Bool
    @Binding var tutorialCategory: Category?
    @Binding var isLoading: Bool
    @Binding var shouldReload: Bool

    @State private var needsSettingsActivation = false
    @State private var isProtectionEnabled: Bool = Prefs[.isProtectionActive]

    private let timer = Timer.publish(every: 10, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack(spacing: 0) {
            LogoView()
            ShieldView(shieldState: isProtectionEnabled ? .active : .inactive)
            ActivationRow(isLoading: $isLoading, isProtectionEnabled: $isProtectionEnabled) { value in
                toggleProtection(value)
            }
            if isProtectionEnabled {
                ProtectionLevelRow {
                    showLevel = true
                }
            }
            AllowlistRow {
                showAllowlist = true
            }
            Spacer()
            FixIssuesView(isLoading: $isLoading,
                          needsSettingsActivation: $needsSettingsActivation,
                          isProtectionEnabled: $isProtectionEnabled,
                          shouldPresentTutorial: $showTutorial)
        }
        .padding()
        .viewSkinning()
        .onReceive(timer) { _ in
            checkStateOfContentBlockers()
        }
        .onAppear {
            checkStateOfContentBlockers()
        }
        .onDisappear {
            timer.upstream.connect().cancel()
        }
    }

    private func toggleProtection(_ value: Bool) {
        shouldReload = true
        Prefs[.isProtectionActive] = value
        isProtectionEnabled = value
    }

    private func checkStateOfContentBlockers() {
        Task(priority: .userInitiated) {
            let categories = await ContentBlockersStateProvider.categoriesThatNeedsSettingsActivation()
            tutorialCategory = categories.isEmpty ? nil : categories.first
            needsSettingsActivation = !categories.isEmpty
            if Prefs[.hasSeenTutorial] != true {
                showTutorial = needsSettingsActivation
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(showLevel: .constant(false),
                 showAllowlist: .constant(false),
                 showTutorial: .constant(true),
                 tutorialCategory: .constant(.ads),
                 isLoading: .constant(false),
                 shouldReload: .constant(false))
    }
}
