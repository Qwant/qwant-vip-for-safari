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
                            Text(isInAllowlist ? localized("macOS.Extension.Main.Allowlisting") : localized("macOS.Extension.Main.Unallowlisting"))
                                .foregroundColor(.qw_text_secondary)
                                .multilineTextAlignment(.center)
                        }
                        Spacer()
                    }
                }

                Spacer()
                if !isAllowlisting {
                    if isProtectionEnabled {
                        HStack {
                            Text(isInAllowlist ? localized("macOS.Extension.Main.Protection.Allowlisted") : localized("macOS.Extension.Main.Protection.NotAllowlisted"))
                                .font(.system(size: 15, weight: .bold))
                                .foregroundColor(isInAllowlist ? .qw_red : .qw_green)

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
                            Text(localized("macOS.Extension.Main.GlobalProtection.Disabled"))
                                .font(.system(size: 15, weight: .bold))
                                .foregroundColor(.qw_text_secondary)

                            Spacer()

                            Button {
                                let scheme = URL(string: "qwantvip://prefs:root=app")!
                                NSWorkspace.shared.open(scheme)
                            } label: {
                                Text(localized("macOS.Extension.Main.GlobalProtection.TurnOn"))
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 6)
                                    .frame(minWidth: 170)
                            }
                            .buttonStyle(FlatRoundedButtonStyle())
                        }
                    }
                }

                HStack {
                    Text(localized("macOS.Extension.Main.DefaultSearchEngine"))
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
                        Text(localized("macOS.Extension.Main.Settings"))
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
