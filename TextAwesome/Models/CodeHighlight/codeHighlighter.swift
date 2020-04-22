//
//  codeHighlighter.swift
//  TextAwesome
//
//  Created by Peter Luo on 2020/3/31.
//  Copyright © 2020 Peter Luo. All rights reserved.
//

import UIKit

class CodeHighlighter {

	static func initializeLangDictionaries() {
		initializeSwiftLangDictionary()
	}

	static func highlight(_ attributedString: NSAttributedString, fileExtension: String)
		-> NSAttributedString
	{
		let result = NSMutableAttributedString(attributedString: attributedString)
		let string = attributedString.string

		let dict = langDictionaries.filter {
			guard let id = $0["id"] else { return false }
			return id == [fileExtension]
		}.first

		func scan(dictID: String, color: UIColor) {

			guard let dict = dict?[dictID] else { return }
			let ranges = Utils.findNSRangeOfMultiplePatterns(
				string: string, patterns: dict, caseSensitive: true)
			for range in ranges {
				result.addAttributes(
					[
						NSAttributedString.Key.foregroundColor: color
					], range: range)
			}

		}

		scan(dictID: "keywords", color: .systemBlue)
		scan(dictID: "types", color: .systemGreen)
		scan(dictID: "numbers", color: .systemPurple)
		scan(dictID: "strings", color: .systemRed)
		scan(dictID: "comments", color: .systemTeal)

		return result
	}
}
