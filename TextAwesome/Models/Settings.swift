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

enum InterfaceStyle: Int {
    case system, light, dark
    
    var uiUserInterfaceStyle : UIUserInterfaceStyle {
        return UIUserInterfaceStyle(rawValue: self.rawValue) ?? .unspecified
    }
    
    var uiKeyboardAppearance : UIKeyboardAppearance {
        switch self {
        case .system : return .default
        case .light  : return .light
        case .dark   : return .dark
        }
    }
}

struct Settings {
    
    struct Keys {
        static var fontStyle = "TextAwesome_FontStyle"
        static var fontSize = "TextAwesome_FontSize"
        static var caseSensitiveTextSearching = "TextAwesome_CaseSensitiveTextSearching"
        static var syntaxHighlight = "TextAwesome_SyntaxHighlight"
        static var interfaceStyle = "TextAwesome_InterfaceStyle"
    }

	static var fontStyle: FontStyle {
		get {
			let raw = UserDefaults.standard.integer(forKey: Settings.Keys.fontStyle)
			return FontStyle(rawValue: raw) ?? FontStyle.monoSpace
		}
		set(newFontType) {
			let raw = newFontType.rawValue
			UserDefaults.standard.set(raw, forKey: Settings.Keys.fontStyle)
		}
	}

	static var fontSize: CGFloat {
		get {
			return CGFloat(UserDefaults.standard.float(forKey: Settings.Keys.fontSize))
		}
		set(newSize) {
			UserDefaults.standard.set(newSize, forKey: Settings.Keys.fontSize)
		}
	}

	static var caseSensitiveTextSearching: Bool {
		get {
			return UserDefaults.standard.bool(forKey: Settings.Keys.caseSensitiveTextSearching)
		}
		set(newValue) {
			UserDefaults.standard.set(newValue, forKey: Settings.Keys.caseSensitiveTextSearching)
		}
	}

	static var enableSyntaxHighlight: Bool {
		get {
            return UserDefaults.standard.bool(forKey: Settings.Keys.syntaxHighlight)
		}
		set(newValue) {
            UserDefaults.standard.set(newValue, forKey: Settings.Keys.syntaxHighlight)
		}
	}
    
    static var interfaceStyle: InterfaceStyle {
        get {
            let raw = UserDefaults.standard.integer(forKey: Settings.Keys.interfaceStyle)
            return InterfaceStyle(rawValue: raw) ?? .system
        }
        set(newValue) {
            let raw = newValue.rawValue
            UserDefaults.standard.set(raw, forKey: Settings.Keys.interfaceStyle)
            NotificationCenter.default.post(Notification(name: .InterfaceStyleChanged))
        }
    }
    
}
