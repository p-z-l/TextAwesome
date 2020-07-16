//
//  c.swift
//  TextAwesome
//
//  Created by Peter Luo on 2020/7/16.
//  Copyright © 2020 Peter Luo. All rights reserved.
//

import Foundation

let c = LanguageLibrary(
    id: "c",
    keywords: Token.array(
        "break",
        "case",
        "char",
        "const",
        "continue",
        "default",
        "do",
        "else",
        "enum",
        "extern",
        "float",
        "for",
        "goto",
        "if",
        "long",
        "register",
        "return",
        "short",
        "signed",
        "sizeof",
        "static",
        "switch",
        "typedef",
        "union",
        "unsigned",
        "void",
        "volatile",
        "while"
    ),
    types: Token.array(
        "bool",
        "char",
        "double",
        "float",
        "int"
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
        requiresSeperatorStart: false,
        requiresSeperatorEnd: false
    ),
    identifiers: nil,
    macros: Token.array(
        "#(.*)",
        requiresSeperatorStart: false,
        requiresSeperatorEnd: false
    )
)
