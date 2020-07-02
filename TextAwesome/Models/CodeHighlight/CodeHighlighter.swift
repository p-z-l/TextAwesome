//
//  CodeHighlighter.swift
//  TextAwesome
//
//  Created by Peter Luo on 2020/3/31.
//  Copyright © 2020 Peter Luo. All rights reserved.
//

import UIKit

struct CodeHighlighter {
    
    init() {
        self.loadLibraries()
        self.loadThemes()
    }
    
    func loadLibraries() {
        LibrariesManager.libraries.append(swift)
    }
    
    func loadThemes() {
        ThemesManager.themes.append(basic)
    }
    
    func highlightedCode(for string: String, fileExtension: String) -> NSAttributedString {
        guard let theme = ThemesManager.theme(of: "basic") else {
            return NSAttributedString(string: string)
        }
        guard let library = LibrariesManager.library(of: fileExtension) else {
            return NSAttributedString(string: string)
        }
        return self.colorize(string, forLibrary: library, theme: theme)
    }
    
    func highlightedCode(for attributedString: NSAttributedString, fileExtension: String) -> NSAttributedString {
        let string = attributedString.string
        guard let theme = ThemesManager.theme(of: "basic") else {
            return attributedString
        }
        guard let library = LibrariesManager.library(of: fileExtension) else {
            return attributedString
        }
        return self.colorize(string, forLibrary: library, theme: theme)
	}
    
    private func colorize(_ string: String, forLibrary library: LanguageLibrary, theme: SyntaxTheme) -> NSAttributedString {
        
        let result = NSMutableAttributedString(string: string, attributes: [
            NSAttributedString.Key.font : Settings.fontStyle.uiFont,
            NSAttributedString.Key.foregroundColor : theme.textColor
        ])
        
        func scan(for keywords: [Keyword]?, color: UIColor) {
            guard keywords != nil else { return }
            var ranges = [NSRange]()
            for keyword in keywords! {
                ranges.append(contentsOf: keyword.rangesOfMatches(string))
            }
            for range in ranges {
                result.addAttributes(
                    [
                        NSAttributedString.Key.foregroundColor: color
                    ], range: range)
            }

        }

        scan(for: library.numbers, color: theme.numbersColor)
        scan(for: library.strings, color: theme.stringsColor)
        scan(for: library.types, color: theme.typesColor)
        scan(for: library.keywords, color: theme.keywordsColor)
        scan(for: library.comments, color: theme.commentsColor)
        
        return result
    }
}
