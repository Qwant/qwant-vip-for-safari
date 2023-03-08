//
//  SafariExtensionMainView.swift
//  Qwant VIP for macOS
//
//  Created by Jerome Boursier on 07/02/2023.
//

import SwiftUI

struct SafariExtensionMainView: View {
    @Binding var isProtectionEnabled: Bool
    @Binding var isInAllowlist: Bool
    @Binding var isDefaultSearchEngine: Bool
    weak var hostingController: SafariExtensionViewController?

    @State private var isAllowlisting = false

    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                LogoView()

                Spacer()

                if !isAllowlisting {
                    if isProtectionEnabled {
                        ShieldView(shieldState: isInAllowlist ? .paused : .active)
                    } else {
                        ShieldView(shieldState: .inactive)
                    }
                } else {
                    HStack {
                        Spacer()
                        ProgressView {
                            Text(isInAllowlist ? "macOS.Extension.Main.Allowlisting" : "macOS.Extension.Main.Unallowlisting")
                                .foregroundColor(.qw.text.secondary)
                                .multilineTextAlignment(.center)
                        }
                        Spacer()
                    }
                }

                Spacer()
                if !isAllowlisting {
                    if isProtectionEnabled {
                        HStack {
                            Text(isInAllowlist ? "macOS.Extension.Main.Protection.Allowlisted" : "macOS.Extension.Main.Protection.NotAllowlisted")
                                .font(.system(size: 15, weight: .bold))
                                .foregroundColor(isInAllowlist ? .qw.palette.red : .qw.palette.green)

                            Spacer()

                            Toggle("", isOn: !$isInAllowlist)
                                .toggleStyle(ColoredToggleStyle())
                                .onChange(of: isInAllowlist) { _ in
                                    Task {
                                        await onAllowlistToggleChange()
                                    }
                                }
                        }
                    } else {
                        HStack {
                            Text("macOS.Extension.Main.GlobalProtection.Disabled")
                                .font(.system(size: 15, weight: .bold))
                                .foregroundColor(.qw.text.secondary)

                            Spacer()

                            Button {
                                let scheme = URL(string: "qwantvip://prefs:root=app")!
                                NSWorkspace.shared.open(scheme)
                            } label: {
                                Text("macOS.Extension.Main.GlobalProtection.TurnOn")
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 6)
                                    .frame(minWidth: 170)
                            }
                            .buttonStyle(FlatRoundedButtonStyle())
                        }
                    }
                }

                HStack {
                    Text("macOS.Extension.Main.DefaultSearchEngine")
                        .font(.system(size: 15))

                    Spacer()

                    Toggle("", isOn: $isDefaultSearchEngine)
                        .toggleStyle(ColoredToggleStyle(offColor: .gray))
                        .onChange(of: isDefaultSearchEngine) { _ in
                            hostingController?.onSearchEngineToggleChange()
                        }
                }
            }
            .padding()

            if isProtectionEnabled {
                Button {
                    let scheme = URL(string: "qwantvip://prefs:root=app")!
                    NSWorkspace.shared.open(scheme)
                } label: {
                    HStack {
                        Spacer()
                        Text("macOS.Extension.Main.Settings")
                            .padding(.vertical, 6)
                        Spacer()
                    }
                }
                .padding([.horizontal, .bottom])
                .buttonStyle(FlatRoundedButtonStyle())
            }
        }
    }

    private func onAllowlistToggleChange() async {
        isAllowlisting = true
        await hostingController?.onToggleChange()
        isAllowlisting = false
    }
}

struct SafariExtensionMainView_Previews: PreviewProvider {
    static var previews: some View {
        SafariExtensionMainView(isProtectionEnabled: .constant(true),
                                isInAllowlist: .constant(false),
                                isDefaultSearchEngine: .constant(true))
    }
}
