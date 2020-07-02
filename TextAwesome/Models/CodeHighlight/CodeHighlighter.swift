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
    }
    
    func loadLibraries() {
        LibrariesManager.library.append(swift)
    }
    
    func highlightedCode(for string: String, fileExtension: String) -> NSAttributedString {
        guard let library = LibrariesManager.library(of: fileExtension) else {
            return NSAttributedString(string: string)
        }
        return self.colorize(string, forLibrary: library)
    }
    
    func highlightedCode(for attributedString: NSAttributedString, fileExtension: String) -> NSAttributedString {
        let string = attributedString.string
        guard let library = LibrariesManager.library(of: fileExtension) else {
            return NSAttributedString(string: string)
        }
        return self.colorize(string, forLibrary: library)
	}
    
    private func colorize(_ string: String, forLibrary library: LanguageLibrary) -> NSAttributedString {
        
        let result = NSMutableAttributedString(string: string, attributes: [
            NSAttributedString.Key.font : Settings.fontStyle.uiFont,
            NSAttributedString.Key.foregroundColor : UIColor(named: "Text Color")!
        ])
        
        func scan(for strings: [String]?, color: UIColor) {
            guard strings != nil else { return }
            let ranges = Utils.findNSRangeOfMultiplePatterns(
                string: string, patterns: strings!, caseSensitive: true)
            for range in ranges {
                result.addAttributes(
                    [
                        NSAttributedString.Key.foregroundColor: color
                    ], range: range)
            }

        }

        scan(for: library.keywords, color: .systemBlue)
        scan(for: library.types, color: .systemGreen)
        scan(for: library.numbers, color: .systemPurple)
        scan(for: library.strings, color: .systemRed)
        scan(for: library.comments, color: .systemTeal)
        
        return result
    }
}
