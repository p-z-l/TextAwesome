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

struct SyntaxTheme {
    
    var id               : String
    var textColor        : UIColor
    var backgroundColor  : UIColor
    var keywordsColor    : UIColor
    var typesColor       : UIColor
    var commentsColor    : UIColor
    var numbersColor     : UIColor
    var stringsColor     : UIColor
    var identifiersColor : UIColor
    var macrosColor      : UIColor
    
}
