//
//  Configs.swift
//  code_challenge
//
//  Created by Serhii Semenov on 21.03.2021.
//

import Foundation

struct Configs: Codable {
    var selectedAccount: String = ""
}

struct ConfigManager {
    private static let CONFIG_KEY = "Configs"
    private static let userDefaults = UserDefaults.standard
    static let shared = ConfigManager()
    
    private var configs = Configs()
    
    private init() {
        // load configs
        if let savedConfigs = ConfigManager.userDefaults.object(forKey: ConfigManager.CONFIG_KEY) as? Data {
            if let loadedConfigs = try? JSONDecoder().decode(Configs.self, from: savedConfigs) {
                configs = loadedConfigs
            }
        }
    }
    
    private func save() {
        // save configs
        if let encoded = try? JSONEncoder().encode(configs) {
            ConfigManager.userDefaults.set(encoded, forKey: ConfigManager.CONFIG_KEY)
        }
    }
    
    var selectedAccount: String {
        get {
            return configs.selectedAccount
        }
        set {
            configs.selectedAccount = newValue
            save()
        }
    }
}
