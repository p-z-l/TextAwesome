//
//  swift.swift
//  TextAwesome
//
//  Created by Peter Luo on 2020/3/31.
//  Copyright © 2020 Peter Luo. All rights reserved.
//

import Foundation

let swift = LanguageLibrary(
    id: "swift",
    keywords: Keyword.array(
        "#selector",
        "@[a-zA-Z]+",
        "as",
        "break",
        "catch",
        "class",
        "continue",
        "convenience",
        "deinit",
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
        "switch",
        "throw",
        "true",
        "try",
        "try",
        "typealias",
        "var",
        "where",
        "while",
        "willSet"
    ),
    types: Keyword.array(
        "(.+)<(.+)>",
        "(NS|UI)[A-Z][a-zA-Z]+",
        "Array",
        "Bool",
        "Character",
        "Data",
        "Date",
        "Dictionary",
        "Double",
        "Float",
        "Float16",
        "Float32",
        "Float64",
        "Float8",
        "Int",
        "Int16",
        "Int32",
        "Int64",
        "Int8",
        "String"
    ),
        comments: Keyword.array(
        "//(.*)",
        "/\\*(.*)\\*/",
        requiresSeperatorStart: false,
        requiresSeperatorEnd: false
    ),numbers: Keyword.array(
        "[0-9]+",
        requiresSeperatorStart: false,
        requiresSeperatorEnd: false
    ),
        strings: Keyword.array(
        "\"(.*)\"",
        "\"\"\"(.*)\"\"\"",
        requiresSeperatorStart: false,
        requiresSeperatorEnd: false
    ),
        identifiers: Keyword.array(
//        "\\b(.+)\\(",
//        requiresSeperatorStart: false,
//        requiresSeperatorEnd: false,
//        endIgnore: 1
    )
)

