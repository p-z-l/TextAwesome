//
//  LanguageLibrary.swift
//  TextAwesome
//
//  Created by Peter Luo on 2020/3/31.
//  Copyright © 2020 Peter Luo. All rights reserved.
//

import Foundation

struct LibrariesManager {
    
    static var libraries = [LanguageLibrary]()
    
    static func library(of id: String) -> LanguageLibrary? {
        for library in LibrariesManager.libraries {
            if library.id == id {
                return library
            }
        }
        return nil
    }
    
    static func hasLibrary(of id: String?) -> Bool {
        guard id != nil else { return false }
        for library in LibrariesManager.libraries {
            if library.id == id {
                return true
            }
        }
        return false
    }
    
}

struct LanguageLibrary {
    
    var id          : String
    var keywords    : [Token]?
    var types       : [Token]?
    var comments    : [Token]?
    var numbers     : [Token]?
    var strings     : [Token]?
    var identifiers : [Token]?
    var macros      : [Token]?
    
}
