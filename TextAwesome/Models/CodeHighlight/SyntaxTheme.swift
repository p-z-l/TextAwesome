//
//  SyntaxTheme.swift
//  TextAwesome
//
//  Created by Peter Luo on 2020/7/2.
//  Copyright © 2020 Peter Luo. All rights reserved.
//

import UIKit

struct ThemesManager {
    
    static var themes = [SyntaxTheme]()
    
    static func theme(of id: String) -> SyntaxTheme? {
        for theme in ThemesManager.themes {
            if theme.id == id {
                return theme
            }
        }
        return nil
    }
    
}

struct SyntaxTheme : Codable {
    
    var id               : String
    var textColor        : Color
    var backgroundColor  : Color
    var keywordsColor    : Color
    var typesColor       : Color
    var commentsColor    : Color
    var numbersColor     : Color
    var stringsColor     : Color
    var identifiersColor : Color
    var macrosColor      : Color
    
}

struct Color: Codable {
    
    var r : CGFloat = 0
    var g : CGFloat = 0
    var b : CGFloat = 0
    
    init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.r = r
        self.g = g
        self.b = b
    }
    
    init(_ hex: Int) {
        self.init(
            r: CGFloat((hex >> 16) & 0xFF)/255,
            g: CGFloat((hex >> 8) & 0xFF)/255,
            b: CGFloat(hex & 0xFF)/255
        )
    }
    
    init(uiColor: UIColor) {
        uiColor.getRed(&r, green: &g, blue: &b, alpha: nil)
    }
    
    var uiColor: UIColor {
        return UIColor(red: r, green: g, blue: b, alpha: 1.0)
    }
}
