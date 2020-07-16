//
//  CodeHighlighter.swift
//  TextAwesome
//
//  Created by Peter Luo on 2020/3/31.
//  Copyright © 2020 Peter Luo. All rights reserved.
//

import UIKit

struct CodeHighlighter {
    
    private var library: LanguageLibrary?
    
    init(fileExtension: String) {
        self.library = LibrariesManager.library(of: fileExtension)
    }
    
    init() {
        self.init(fileExtension: "")
    }
    
    static func loadLibraries() {
        LibrariesManager.libraries.removeAll()
        
        LibrariesManager.libraries.append(c)
        LibrariesManager.libraries.append(css)
        LibrariesManager.libraries.append(html)
        LibrariesManager.libraries.append(py)
        LibrariesManager.libraries.append(swift)
    }
    
    static func loadThemes() {
        ThemesManager.themes.removeAll()
        
        ThemesManager.themes.append(basic)
        ThemesManager.themes.append(onedark)
        ThemesManager.themes.append(spacemacs_dark)
        ThemesManager.themes.append(spacemacs_light)
    }
    
    func highlightedCode(for string: String, fileExtension: String) -> NSAttributedString {
        let theme = Settings.syntaxTheme
        return self.colorize(string, theme: theme)
    }
    
    func highlightedCode(for attributedString: NSAttributedString, fileExtension: String) -> NSAttributedString {
        let string = attributedString.string
        let theme = Settings.syntaxTheme
        return self.colorize(string, theme: theme)
	}
    
    private func colorize(_ string: String, theme: SyntaxTheme) -> NSAttributedString {
        
        guard library != nil else { return NSAttributedString(string: string) }
        
        let result = NSMutableAttributedString(string: string, attributes: [
            NSAttributedString.Key.font : Settings.fontStyle.uiFont,
            NSAttributedString.Key.foregroundColor : theme.textColor
        ])
        
        func scan(for keywords: [Token]?, color: UIColor) {
            guard keywords != nil else { return }
            var ranges = [NSRange]()
            for keyword in keywords! {
                ranges.append(contentsOf: keyword.rangesOfMatches(string))
            }
            for range in ranges {
                result.addAttribute(.foregroundColor, value: color, range: range)
            }
        }
        
        scan(for: library!.numbers, color: theme.numbersColor)
        scan(for: library!.types, color: theme.typesColor)
        scan(for: library!.identifiers, color: theme.identifiersColor)
        scan(for: library!.keywords, color: theme.keywordsColor)
        scan(for: library!.macros, color: theme.macrosColor)
        scan(for: library!.strings, color: theme.stringsColor)
        scan(for: library!.comments, color: theme.commentsColor)
        
        return result
    }
}
