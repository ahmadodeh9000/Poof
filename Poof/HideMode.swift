//
//  HideMode.swift
//  Poof
//
//  Created by Ahmad Odeh on 07/11/2026.
//



import Foundation

enum Shell {
    @discardableResult
    static func run(_ path: String, _ args: [String]) -> String {
        let process = Process()
        process.executableURL = URL(fileURLWithPath: path)
        process.arguments = args
        let pipe = Pipe()
        process.standardOutput = pipe
        process.standardError = pipe
        do { try process.run() } catch { return "error: \(error)" }
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        process.waitUntilExit()
        return String(decoding: data, as: UTF8.self)
    }
}


enum HideMode {
    private static let store = UserDefaults.standard

    // Saved on disk so a crash or force-quit can be undone on next launch
    static var isHidden: Bool { store.bool(forKey: "isHidden") }

    static func hide() {
        guard !isHidden else { return } // never overwrite the saved originals
        store.set(read("com.apple.finder", "CreateDesktop") ?? true, forKey: "originalCreateDesktop")
        store.set(read("com.apple.dock", "autohide") ?? false, forKey: "originalAutohide")
        store.set(true, forKey: "isHidden")
        write("com.apple.finder", "CreateDesktop", false, restart: "Finder")
        write("com.apple.dock", "autohide", true, restart: "Dock")
    }

    static func restore() {
        guard isHidden else { return }
        write("com.apple.finder", "CreateDesktop", store.bool(forKey: "originalCreateDesktop"), restart: "Finder")
        write("com.apple.dock", "autohide", store.bool(forKey: "originalAutohide"), restart: "Dock")
        store.set(false, forKey: "isHidden")
    }

    // nil when the key isn't set
    private static func read(_ domain: String, _ key: String) -> Bool? {
        let value = Shell.run("/usr/bin/defaults", ["read", domain, key]).trimmingCharacters(in: .whitespacesAndNewlines)
        return value == "1" ? true : value == "0" ? false : nil
    }

    private static func write(_ domain: String, _ key: String, _ value: Bool, restart app: String) {
        Shell.run("/usr/bin/defaults", ["write", domain, key, "-bool", value ? "true" : "false"])
        Shell.run("/usr/bin/killall", [app])
    }
}
