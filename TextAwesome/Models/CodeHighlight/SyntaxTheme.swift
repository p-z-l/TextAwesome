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
