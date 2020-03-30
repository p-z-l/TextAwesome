//
//  Settings.swift
//  TextAwesome
//
//  Created by Peter Luo on 2020/3/30.
//  Copyright © 2020 Peter Luo. All rights reserved.
//

import Foundation

enum Appearance: Int {
    case system,light,dark
}

enum FontType: Int {
    case monoSpace,serif,sansSerif
}

class Settings {
    static var appearance: Appearance {
        get {
            let raw = UserDefaults.standard.integer(forKey: Constants.appearanceKey)
            return Appearance(rawValue: raw) ?? Appearance.system
        }
        set(newAppearance) {
            let raw = newAppearance.rawValue
            UserDefaults.standard.set(raw, forKey: Constants.appearanceKey)
        }
    }
    
    static var fontStyle: FontType {
        get {
            let raw = UserDefaults.standard.integer(forKey: Constants.fontTypeKey)
            return FontType(rawValue: raw) ?? FontType.monoSpace
        }
        set(newFontType) {
            let raw = newFontType.rawValue
            UserDefaults.standard.set(raw, forKey: Constants.fontTypeKey)
        }
    }
}
