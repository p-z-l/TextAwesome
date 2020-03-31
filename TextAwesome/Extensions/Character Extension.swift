//
//  Character Extension.swift
//  TextAwesome
//
//  Created by Peter Luo on 2020/3/31.
//  Copyright © 2020 Peter Luo. All rights reserved.
//

import Foundation

extension Character {
    func isEquivalentTo(_ char: Character, caseSensitive: Bool) -> Bool {
        if !caseSensitive {
            guard Constants.lowToUpCase[char] != self else { return true }
            guard Constants.lowToUpCase[self] != char else { return true }
        }
        return self == char
    }
}
