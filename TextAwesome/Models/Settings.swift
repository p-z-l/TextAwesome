//
//  Settings.swift
//  TextAwesome
//
//  Created by Peter Luo on 2020/3/30.
//  Copyright © 2020 Peter Luo. All rights reserved.
//

import Foundation

enum FontStyle: Int {
    case monoSpace,serif,sansSerif
}

class Settings {
    
    static var fontStyle: FontStyle {
        get {
            let raw = UserDefaults.standard.integer(forKey: Constants.fontTypeKey)
            return FontStyle(rawValue: raw) ?? FontStyle.monoSpace
        }
        set(newFontType) {
            let raw = newFontType.rawValue
            UserDefaults.standard.set(raw, forKey: Constants.fontTypeKey)
        }
    }
}
