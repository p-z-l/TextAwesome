//
//  Utils.swift
//  TextAwesome
//
//  Created by Peter Luo on 2020/3/31.
//  Copyright © 2020 Peter Luo. All rights reserved.
//

import UIKit

class Utils {
    static func findNSRangeOfPattern(string: String, pattern: String, caseSensitive: Bool) -> [NSRange] {
        guard !pattern.isEmpty else { return [NSRange]() }
        var results = [NSRange]()
        var beginIndex: Int?
        var endIndex: Int?
        var matchCount = 0
        for i in 0..<string.count {
            let char = string.getCharOfIndex(i)
            if char.isEquivalentTo(pattern.getCharOfIndex(matchCount), caseSensitive: caseSensitive) {
                if matchCount == 0 {
                    beginIndex = i
                }
                matchCount += 1
            } else {
                matchCount = 0
            }
            if matchCount == pattern.count {
                endIndex = i
                if beginIndex != nil && endIndex != nil {
                    results.append(NSRange(location: beginIndex!, length: endIndex!-beginIndex!+1))
                }
                matchCount = 0
            }
        }
        return results
    }
    
    static func attributeMatchingResults(_ attributedString: NSMutableAttributedString,
                                       pattern: String,
                                       caseSensitive: Bool,
                                       attributes: [NSAttributedString.Key:Any]) {
        let result = attributedString
        let searchResults = Utils.findNSRangeOfPattern(string: attributedString.string, pattern: pattern, caseSensitive: caseSensitive)
        
        for range in searchResults {
            result.addAttribute(.backgroundColor, value: UIColor.systemYellow, range: range)
            result.addAttribute(.foregroundColor, value: UIColor.darkText, range: range)
        }
    }
}
