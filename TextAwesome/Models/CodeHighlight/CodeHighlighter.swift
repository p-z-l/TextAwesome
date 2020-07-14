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
        self.loadLibraries()
        self.loadThemes()
        
        self.library = LibrariesManager.library(of: fileExtension)
    }
    
    init() {
        self.init(fileExtension: "")
    }
    
    private func loadLibraries() {
        LibrariesManager.libraries.removeAll()
        LibrariesManager.libraries.append(swift)
        LibrariesManager.libraries.append(py)
    }
    
    private func loadThemes() {
        ThemesManager.themes.removeAll()
        ThemesManager.themes.append(basic)
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
        
        func scan(for keywords: [Keyword]?, color: UIColor) {
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
        scan(for: library!.strings, color: theme.stringsColor)
        scan(for: library!.comments, color: theme.commentsColor)
        
        return result
    }
}
