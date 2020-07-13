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
                      requiresSeperatorStart: Bool = true,
                      requiresSeperatorEnd: Bool = true,
                      startIgnore: Int = 0,
                      endIgnore: Int = 0) -> [Keyword] {
        var results = [Keyword]()
        for pattern in patterns {
            let keyword : Keyword = {
                var result = Keyword(pattern)
                result.requiresSeperatorStart = requiresSeperatorStart
                result.requiresSeperatorEnd = requiresSeperatorEnd
                result.startIgnore(startIgnore)
                result.endIgnore(endIgnore)
                return result
            }()
            results.append(keyword)
        }
        return results
    }
    
    fileprivate static let seperatorsPattern = "[\0|\n|\t| |,|.|/|?|!|+|-|*|/|=|(|)|[|]|{|}|<|>:|]"
    
    fileprivate(set) var pattern: String
    
    private var startIgnorance = 0
    
    private var endIgnorance = 0
    
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
    
    mutating func startIgnore(_ ignorance: Int) {
        self.startIgnorance = ignorance
    }
    
    mutating func endIgnore(_ ignorance: Int) {
        self.endIgnorance = ignorance
    }
    
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
        let start : Int = {
            if self.requiresSeperatorStart {
                return self.startIgnorance + 1
            } else {
                return self.startIgnorance
            }
        }()
        let end : Int = {
            if self.requiresSeperatorEnd {
                return self.endIgnorance + 1
            } else {
                return self.endIgnorance
            }
        }()
        for match in matches {
            let range = NSRange(location: match.range.location+start,
                                length: match.range.length-end-start)
            results.append(range)
        }
        return results
    }
    
}
