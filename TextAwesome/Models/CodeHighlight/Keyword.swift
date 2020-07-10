//
//  Keyword.swift
//  TextAwesome
//
//  Created by Peter Luo on 2020/7/2.
//  Copyright © 2020 Peter Luo. All rights reserved.
//

import Foundation

struct Keyword {
    
    init(_ pattern: String, requiresSepertorStart: Bool = true, requiresSeperatorEnd: Bool = true) {
        self.pattern = pattern
        self.requiresSeperatorStart = requiresSepertorStart
        self.requiresSeperatorEnd = requiresSeperatorEnd
    }
    
    static func array(_ patterns: String...,
                      requiresSeperatorStart: Bool = false,
                      requiresSeperatorEnd: Bool = false) -> [Keyword] {
        var results = [Keyword]()
        for pattern in patterns {
            results.append(Keyword(pattern))
        }
        return results
    }
    
    fileprivate static let seperatorsPattern = "[\0|\n|\t| |,|.|/|?|!|+|-|*|/|=|(|)|[|]|{|}|<|>:|]"
    
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
            pattern = "\(Keyword.seperatorsPattern)\(pattern)"
        }
        if requiresSeperatorEnd {
            pattern = "\(pattern)\(Keyword.seperatorsPattern)"
        }
        do{
            return try NSRegularExpression(pattern: pattern)
        } catch {
            fatalError("Failed to initilize NSRegularExpression using pattern: \(pattern)")
        }
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
        return Keyword(self.pattern,
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
