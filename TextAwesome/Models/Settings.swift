//
//  Settings.swift
//  TextAwesome
//
//  Created by Peter Luo on 2020/3/30.
//  Copyright © 2020 Peter Luo. All rights reserved.
//

import UIKit

enum FontStyle: Int {
    case monoSpace,serif,sansSerif
}

class Settings {
    
    static var fontStyle: FontStyle {
        get {
            let raw = UserDefaults.standard.integer(forKey: Constants.fontStyleKey)
            return FontStyle(rawValue: raw) ?? FontStyle.monoSpace
        }
        set(newFontType) {
            let raw = newFontType.rawValue
            UserDefaults.standard.set(raw, forKey: Constants.fontStyleKey)
        }
    }
    
    static var fontSize: CGFloat {
        get {
            var size = CGFloat(UserDefaults.standard.float(forKey: Constants.fontSizeKey))
            if size < 12 {
                size = 18
            }
            return size
        }
        set(newSize) {
            UserDefaults.standard.set(newSize, forKey: Constants.fontSizeKey)
        }
    }
}
