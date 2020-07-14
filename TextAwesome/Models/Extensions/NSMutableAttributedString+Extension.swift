//
//  NSMutableAttributedString+Extension.swift
//  TextAwesome
//
//  Created by Peter Luo on 2020/7/14.
//  Copyright © 2020 Peter Luo. All rights reserved.
//

import UIKit

extension NSMutableAttributedString {
    
    func highlight(pattern: String, caseSensitive: Bool = false) {
        let searchResults = self.string.rangesOfPattern(
            pattern,
            caseSensitive: caseSensitive)

        for range in searchResults {
            self.addAttribute(.backgroundColor, value: UIColor.systemYellow, range: range)
            self.addAttribute(.foregroundColor, value: UIColor.darkText, range: range)
        }
    }
    
}
