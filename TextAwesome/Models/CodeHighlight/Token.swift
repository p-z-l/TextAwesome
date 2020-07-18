//
//  Token.swift
//  TextAwesome
//
//  Created by Peter Luo on 2020/7/2.
//  Copyright © 2020 Peter Luo. All rights reserved.
//

import Foundation

struct Token: Codable {
    
    init(_ pattern: String,
         requiresSepertorStart: Bool = true,
         requiresSeperatorEnd: Bool = true,
         startIgnorance: Int = 0,
         endIgnorance: Int = 0
         ) {
        self.pattern = pattern
        self.requiresSeperatorStart = requiresSepertorStart
        self.requiresSeperatorEnd = requiresSeperatorEnd
        self.startIgnorance = startIgnorance
        self.endIgnorance = endIgnorance
    }
    
    static func array(_ patterns: String...,
                      requiresSeperatorStart: Bool = true,
                      requiresSeperatorEnd: Bool = true,
                      startIgnore: Int = 0,
                      endIgnore: Int = 0) -> [Token] {
        var results = [Token]()
        for pattern in patterns {
            let keyword : Token = {
                return Token(
                    pattern,
                    requiresSepertorStart: requiresSeperatorStart,
                    requiresSeperatorEnd: requiresSeperatorEnd,
                    startIgnorance: startIgnore,
                    endIgnorance: endIgnore
                )
            }()
            results.append(keyword)
        }
        return results
    }
    
    fileprivate static let seperatorsPattern = "\\b"
    
    fileprivate(set) var pattern: String
    
    var startIgnorance = 0
    
    var endIgnorance = 0
    
    private var regex: NSRegularExpression {
        var pattern = self.pattern
        if requiresSeperatorStart {
            pattern = "\(Token.seperatorsPattern)\(pattern)"
        }
        if requiresSeperatorEnd {
            pattern = "\(pattern)\(Token.seperatorsPattern)"
        }
        do{
            return try NSRegularExpression(pattern: pattern)
        } catch {
            fatalError("Failed to initilize NSRegularExpression using pattern: \(pattern)")
        }
    }
    
    fileprivate(set) var requiresSeperatorStart: Bool
    
    fileprivate(set) var requiresSeperatorEnd: Bool
    
    func ignore(start: Int = 0, end: Int = 0) -> Token {
        return Token(
            self.pattern,
            requiresSepertorStart: self.requiresSeperatorStart,
            requiresSeperatorEnd: self.requiresSeperatorEnd,
            startIgnorance: start,
            endIgnorance: end
        )
    }
    
    func requiresSeperator(start: Bool? = nil, end: Bool? = nil) -> Token {
        var requiresOnStart = start
        var requiresAtEnd = end
        if start == nil {
            requiresOnStart = true
        } else if end == nil {
            requiresAtEnd = true
        }
        return Token(self.pattern,
                       requiresSepertorStart: requiresOnStart!,
                       requiresSeperatorEnd: requiresAtEnd!)
    }
    
    func rangesOfMatches(_ string: String) -> [NSRange] {
        var results = [NSRange]()
        let range = NSRange(location: 0, length: string.count)
        let matches = regex.matches(in: string, options: [], range: range)
        for match in matches {
            let range = NSRange(location: match.range.location+startIgnorance,
                                length: match.range.length-startIgnorance-endIgnorance)
            results.append(range)
        }
        return results
    }
    
}
