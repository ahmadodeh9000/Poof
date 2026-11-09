//
//  PoofApp.swift
//  Poof
//
//  Created by Ahmad Odeh on 07/11/2026.
//

import SwiftUI
import ServiceManagement

@main
struct PoofApp: App {
    
    @State private var isClean = false
    @State private var launchAtLogin = SMAppService.mainApp.status == .enabled

    init() {
        HideMode.restore() // undo anything left hidden by a crash or force-quit
    }

        var body: some Scene {
            MenuBarExtra("Poof", systemImage: isClean ? "eye.slash" : "eye") {
                Button(isClean ? "Show Everything" : "Hide Everything") {
                    if isClean {
                        HideMode.restore()  // show icons + restore dock
                    }
                    else {
                        HideMode.hide()     // hide icons + hide dock
                    }
                    isClean = HideMode.isHidden
                }
                Toggle("Launch at Login", isOn: Binding(get: { launchAtLogin }, set: { on in
                    if on { try? SMAppService.mainApp.register() }
                    else { try? SMAppService.mainApp.unregister() }
                    launchAtLogin = SMAppService.mainApp.status == .enabled
                }))
                Divider()
                Button("Quit") {
                    HideMode.restore()
                    NSApplication.shared.terminate(nil)
                }
            }
        }
}
