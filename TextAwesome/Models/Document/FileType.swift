//
//  FileType.swift
//  TextAwesome
//
//  Created by Peter Luo on 2020/3/31.
//  Copyright © 2020 Peter Luo. All rights reserved.
//

import Foundation

struct FileType {
    
	var defaultName: String
	var fileExtension: String
    
    static let txt   = FileType(defaultName: "New Plain Text File", fileExtension: "txt")
    static let swift = FileType(defaultName: "New Swift File", fileExtension: "swift")
    static let py    = FileType(defaultName: "New Python File", fileExtension: "py")
    static let html  = FileType(defaultName: "New HTML File", fileExtension: "html")
    static let css   = FileType(defaultName: "New CSS File", fileExtension: "css")
    static let js    = FileType(defaultName: "New JavaScript File", fileExtension: "js")
    static let java  = FileType(defaultName: "New Java File", fileExtension: "java")
    static let md    = FileType(defaultName: "New Markdown File", fileExtension: "md")
    static let c     = FileType(defaultName: "New C File", fileExtension: "c")
    static let cpp   = FileType(defaultName: "New C++ File", fileExtension: "cpp")
    static let m     = FileType(defaultName: "New Objective-C File", fileExtension: "m")
    static let h     = FileType(defaultName: "New Header File", fileExtension: "h")
    
    static let supportedFileTypes : [FileType] = [
        .txt,
        .swift,
        .py,
        .html,
        .css,
        .js,
        .java,
        .md,
        .c,
        .cpp,
        .m,
        .h,
    ]
    
}
