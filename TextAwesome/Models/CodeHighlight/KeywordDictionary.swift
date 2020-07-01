//
//  KeywordDictionary.swift
//  TextAwesome
//
//  Created by Peter Luo on 2020/3/31.
//  Copyright © 2020 Peter Luo. All rights reserved.
//

import Foundation

class LibrariesManager : NSObject {
    
    override init() {}
    
    static var library = [LanguageLibrary]()
    
    static func library(of id: String) -> LanguageLibrary? {
        for library in LibrariesManager.library {
            if library.id == id {
                return library
            }
        }
        return nil
    }
}

struct LanguageLibrary {
    
    var id: String {
        didSet {
            LibrariesManager.library.append(self)
        }
    }
    var keywords: [String]?
    var types: [String]?
    var comments: [String]?
    var numbers: [String]?
    var strings: [String]?
}
