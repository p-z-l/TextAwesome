//
//  Settings.swift
//  TextAwesome
//
//  Created by Peter Luo on 2020/3/30.
//  Copyright © 2020 Peter Luo. All rights reserved.
//

import UIKit

enum FontStyle: Int {
	case monoSpace, serif, sansSerif
    
    var uiFont: UIFont {
        if let font = Constants.fontDict[self] {
            return font
        } else {
            return UIFont.SFMono(ofSize: Settings.fontSize)
        }
    }
}

struct Settings {

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
			return CGFloat(UserDefaults.standard.float(forKey: Constants.fontSizeKey))
		}
		set(newSize) {
			UserDefaults.standard.set(newSize, forKey: Constants.fontSizeKey)
		}
	}

	static var caseSensitiveTextSearching: Bool {
		get {
			return UserDefaults.standard.bool(forKey: Constants.caseSensitiveKey)
		}
		set(newValue) {
			UserDefaults.standard.set(newValue, forKey: Constants.caseSensitiveKey)
		}
	}

	static var syntaxHighlight: Bool {
		get {
			return UserDefaults.standard.bool(forKey: Constants.syntaxHighlightKey)
		}
		set(newValue) {
			UserDefaults.standard.set(newValue, forKey: Constants.syntaxHighlightKey)
		}
	}
}
