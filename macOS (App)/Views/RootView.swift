//
//  RootView.swift
//  Qwant VIP for macOS
//
//  Created by Jerome Boursier on 25/01/2023.
//

import SwiftUI

struct RootView: View {
    @Environment(\.scenePhase) var scenePhase

    // Tutorial
    @State private var showTutorial = false
    @State private var tutorialCategory: Category?
    // Protection Level
    @State private var showLevel = false
    // Allowlist
    @State private var showAllowlist = false
    // Reload
    @State private var isLoading = false
    @State private var shouldReload = false

    var body: some View {
        VStack {
            if !showLevel && !showAllowlist {
                MainView(showLevel: $showLevel,
                         showAllowlist: $showAllowlist,
                         showTutorial: $showTutorial,
                         tutorialCategory: $tutorialCategory,
                         isLoading: $isLoading,
                         shouldReload: $shouldReload)
                .transition(.move(edge: .leading))
            }
            if showLevel {
                ProtectionLevelView(selectedLevel: Prefs[.protectionLevel],
                                    show: $showLevel,
                                    reload: $shouldReload)
                .transition(.move(edge: .trailing))
            }
            if showAllowlist {
                AllowlistView(show: $showAllowlist,
                              reload: $shouldReload)
                    .transition(.move(edge: .trailing))
            }
        }
        .sheet(isPresented: $showTutorial) {
            TutorialView(category: $tutorialCategory)
                .onDisappear {
                    Prefs[.hasSeenTutorial] = true
                }
        }
        .onChange(of: shouldReload) { newValue in
            onReload(newValue)
        }
        .onChange(of: scenePhase) { newPhase in
            onReload(newPhase == .active)
        }
    }

    private func onReload(_ value: Bool) {
        guard value else { return }

        isLoading = true
        ContentBlockersExceptions.build()
        ContentBlockersListsHandler.computeBlockLists()
        Task(priority: .background) {
            await ContentBlockersJsonBuilder.build()
            await ContentBlockersReloader.reloadAll()
            await MainActor.run {
                isLoading = false
            }
        }
        shouldReload = false
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
