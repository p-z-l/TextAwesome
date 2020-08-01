//
//  CodeHighlighter.swift
//  TextAwesome
//
//  Created by Peter Luo on 2020/3/31.
//  Copyright © 2020 Peter Luo. All rights reserved.
//

import UIKit

struct CodeHighlighter {
    
    private var library: TokenLibrary?
    private var theme: SyntaxTheme
    
    init(fileExtension: String = "", themeName: String = "basic") {
        self.library = LibrariesManager.library(of: fileExtension)
        self.theme = ThemesManager.theme(of: themeName) ?? ThemesManager.theme(of: "basic")!
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
        ThemesManager.themes.append(one_dark)
        ThemesManager.themes.append(one_light)
        ThemesManager.themes.append(solarized_dark)
        ThemesManager.themes.append(solarized_light)
        ThemesManager.themes.append(spacemacs_dark)
        ThemesManager.themes.append(spacemacs_light)
    }
    
    func highlightedCode(for string: String) -> NSAttributedString {
        return self.colorize(string, theme: theme)
    }
    
    func highlightedCode(for attributedString: NSAttributedString) -> NSAttributedString {
        let string = attributedString.string
        return self.colorize(string, theme: theme)
	}
    
    private func colorize(_ string: String, theme: SyntaxTheme) -> NSAttributedString {
        
        guard library != nil else { return NSAttributedString(string: string) }
        
        let result = NSMutableAttributedString(string: string, attributes: [
            NSAttributedString.Key.font : Settings.fontStyle.uiFont,
            NSAttributedString.Key.foregroundColor : theme.textColor.uiColor
        ])
        
        func scan(for keywords: [Token]?, color: UIColor) {
            guard keywords != nil else { return }
//            var ranges = [NSRange]()
//            let regexGroup = DispatchGroup()
//            for keyword in keywords! {
//                regexGroup.enter()
//                ranges.append(contentsOf: keyword.rangesOfMatches(string))
//                regexGroup.leave()
//            }
//            regexGroup.notify(queue: .main) {
//                for range in ranges {
//                    result.addAttribute(.foregroundColor, value: color, range: range)
//                }
//            }
            for keyword in keywords! {
                let ranges = keyword.rangesOfMatches(string)
                for range in ranges {
                    result.addAttribute(.foregroundColor, value: color, range: range)
                }
            }
        }
        
        scan(for: library!.numbers, color: theme.numbersColor.uiColor)
        scan(for: library!.types, color: theme.typesColor.uiColor)
        scan(for: library!.identifiers, color: theme.identifiersColor.uiColor)
        scan(for: library!.keywords, color: theme.keywordsColor.uiColor)
        scan(for: library!.macros, color: theme.macrosColor.uiColor)
        scan(for: library!.strings, color: theme.stringsColor.uiColor)
        scan(for: library!.comments, color: theme.commentsColor.uiColor)
        
        return result
    }
}
