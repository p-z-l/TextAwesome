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
        "import",
        "let",
        "var",
        "if",
        "else",
        "switch",
        "func",
        "struct",
        "class",
        "protocol",
        "enum",
        "private",
        "fileprivate",
        "private\\(set\\)",
        "internal",
        "open",
        "public",
        "static",
        "dynamic",
        "optional",
        "try",
        "get",
        "set",
        "didSet",
        "willSet",
        "#selector",
        "required",
        "convenience",
        "init",
        "deinit",
        "as",
        "some",
        "self",
        "mutating",
        "override",
        "return",
        "final",
        "typealias",
        "inout",
        "for",
        "while",
        "in",
        "do",
        "catch",
        "try",
        "throw",
        "where",
        "extension",
        "@[a-zA-Z]+"
    ),
    types: Keyword.array(
        "Array",
        "Data",
        "Date",
        "Dictionary",
        "String",
        "Character",
        "Int",
        "Int8",
        "Int16",
        "Int32",
        "Int64",
        "Float",
        "Float8",
        "Float16",
        "Float32",
        "Float64",
        "Double",
        "Bool",
        "(NS|UI)[A-Z][a-zA-Z]+",
        "(.+)<(.+)>"
    ), comments: Keyword.array(
        "//(.+)",
        "/\\*((.|\n)*)\\*/",
        requiresSeperatorStart: false,
        requiresSeperatorEnd: false
    ),numbers: Keyword.array(
        "0",
        "1",
        "2",
        "3",
        "4",
        "5",
        "6",
        "7",
        "8",
        "9",
        requiresSeperatorStart: false,
        requiresSeperatorEnd: false
    ), strings: Keyword.array(
        "\"(.+)\"",
        "\"\"\"((.|\n)*)\"\"\"",
        requiresSeperatorStart: false,
        requiresSeperatorEnd: false
    ), identifiers: Keyword.array(
//        "\\b(.+)\\(",
//        requiresSeperatorStart: false,
//        requiresSeperatorEnd: false,
//        endIgnore: 1
    )
)

