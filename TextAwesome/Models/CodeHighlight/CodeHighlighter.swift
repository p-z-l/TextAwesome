//
//  CodeHighlighter.swift
//  TextAwesome
//
//  Created by Peter Luo on 2020/3/31.
//  Copyright © 2020 Peter Luo. All rights reserved.
//

import UIKit

class CodeHighlighter {
    
    static func loadLibraries() {
        LibrariesManager.library.append(swift)
    }
    
	static func highlight(_ attributedString: NSAttributedString, fileExtension: String)
		-> NSAttributedString
	{
		let result = NSMutableAttributedString(attributedString: attributedString)
		let string = attributedString.string

        guard let lib = LibrariesManager.library(of: fileExtension) else { return result }

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

        scan(for: lib.keywords, color: .systemBlue)
        scan(for: lib.types, color: .systemGreen)
        scan(for: lib.numbers, color: .systemPurple)
        scan(for: lib.strings, color: .systemRed)
        scan(for: lib.comments, color: .systemTeal)

		return result
	}
}
