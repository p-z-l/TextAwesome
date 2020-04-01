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
        guard pattern != "" else { return [NSRange]() }
        let range = NSRange(location: 0, length: string.utf16.count)
        var regex = try! NSRegularExpression(pattern: pattern)
        if !caseSensitive {
            regex = try! NSRegularExpression(pattern: pattern,options: .caseInsensitive)
        }
        
        let matches = regex.matches(in: string, options: [], range: range)
        
        var result = [NSRange]()
        for match in matches {
            result.append(match.range)
        }
        return result
    }
    
    static func findNSRangeOfMultiplePatterns(string: String, patterns: [String], caseSensitive: Bool) -> [NSRange] {
        var result = [NSRange]()
        for pattern in patterns {
            let ranges = Utils.findNSRangeOfPattern(string: string, pattern: pattern, caseSensitive: caseSensitive)
            for range in ranges {
                result.append(range)
            }
        }
        return result
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
