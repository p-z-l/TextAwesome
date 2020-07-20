//
//  swift.swift
//  TextAwesome
//
//  Created by Peter Luo on 2020/3/31.
//  Copyright © 2020 Peter Luo. All rights reserved.
//

import Foundation

let swift = TokenLibrary(
    id: "swift",
    keywords: Token.array(
        "as",
        "break",
        "catch",
        "case",
        "class",
        "continue",
        "convenience",
        "deinit",
        "default",
        "didSet",
        "do",
        "dynamic",
        "else",
        "enum",
        "extension",
        "false",
        "fileprivate",
        "fileprivate\\(set\\)",
        "final",
        "for",
        "func",
        "get",
        "if",
        "import",
        "in",
        "init",
        "inout",
        "internal",
        "is",
        "let",
        "mutating",
        "open",
        "optional",
        "override",
        "private",
        "private\\(set\\)",
        "protocol",
        "public",
        "required",
        "return",
        "self",
        "set",
        "some",
        "static",
        "struct",
        "super",
        "switch",
        "throw",
        "throws",
        "true",
        "try",
        "try",
        "typealias",
        "var",
        "weak",
        "lazy",
        "where",
        "while",
        "willSet"
    ) + Token.array(
        "#selector",
        "@[a-zA-Z]+",
        requiresSeperatorStart: false
    ),
    types: Token.array(
        "(.+)<(.+)>",
        "(NS|UI|CG|SK|SCN)[A-Z][a-zA-Z]+",
        "Array",
        "Bool",
        "Character",
        "Data",
        "Date",
        "Dictionary",
        "Double",
        "Float",
        "Float(8|16|32|64)",
        "Int",
        "Int(8|16|32|64)",
        "String"
    ),
    comments: Token.array(
        "//(.*)",
        "/\\*(.*)\\*/",
        requiresSeperatorStart: false,
        requiresSeperatorEnd: false
    ),
    numbers: Token.array(
        "[0-9]+",
        requiresSeperatorStart: false,
        requiresSeperatorEnd: false
    ),
    strings: Token.array(
        "\"(.*)\"",
        "\"\"\"(.*)\"\"\"",
        requiresSeperatorStart: false,
        requiresSeperatorEnd: false
    ),
    identifiers: Token.array(
//        "\\b(.+)\\(",
//        requiresSeperatorStart: false,
//        requiresSeperatorEnd: false,
//        endIgnore: 1
    )
)

