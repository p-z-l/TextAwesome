//
//  Keyword.swift
//  TextAwesome
//
//  Created by Peter Luo on 2020/7/2.
//  Copyright © 2020 Peter Luo. All rights reserved.
//

import Foundation

struct Keyword {
    
    init(pattern: String, requiresSepertorStart: Bool, requiresSeperatorEnd: Bool) {
        self.pattern = pattern
        self.requiresSeperatorStart = requiresSepertorStart
        self.requiresSeperatorEnd = requiresSeperatorEnd
    }
    
    init(_ pattern: String) {
        self.init(pattern: pattern, requiresSepertorStart: true, requiresSeperatorEnd: true)
    }
    
    private let seperatorsPattern = "[\n|\t| |,|.|/|?|!|+|-|*|/|=|(|)|[|]|{|}|<|>:|]"
    
    fileprivate(set) var pattern: String
    
    private var startIgnorance: Int {
        if requiresSeperatorEnd {
            return 1
        } else {
            return 0
        }
    }
    
    private var endIgnorance: Int {
        if requiresSeperatorEnd {
            return 1
        } else {
            return 0
        }
    }
    
    private var regex: NSRegularExpression {
        var pattern = self.pattern
        if requiresSeperatorStart {
            pattern = "\(seperatorsPattern)\(pattern)"
        }
        if requiresSeperatorEnd {
            pattern = "\(pattern)\(seperatorsPattern)"
        }
        return try! NSRegularExpression(pattern: pattern)
    }
    
    fileprivate(set) var requiresSeperatorStart: Bool
    
    fileprivate(set) var requiresSeperatorEnd: Bool
    
    func requiresSeperator(start: Bool? = nil, end: Bool? = nil) -> Keyword {
        var requiresOnStart = start
        var requiresAtEnd = end
        if start == nil {
            requiresOnStart = true
        } else if end == nil {
            requiresAtEnd = true
        }
        return Keyword(pattern: self.pattern,
                       requiresSepertorStart: requiresOnStart!,
                       requiresSeperatorEnd: requiresAtEnd!)
    }
    
    func rangesOfMatches(_ string: String) -> [NSRange] {
        var results = [NSRange]()
        let range = NSRange(location: 0, length: string.count)
        let matches = regex.matches(in: string, options: [], range: range)
        for match in matches {
            let range = NSRange(location: match.range.location+startIgnorance,
                                length: match.range.length-endIgnorance-startIgnorance)
            results.append(range)
        }
        return results
    }
    
}
