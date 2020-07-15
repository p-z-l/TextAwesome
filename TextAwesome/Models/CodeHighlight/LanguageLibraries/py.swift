//
//  py.swift
//  TextAwesome
//
//  Created by Peter Luo on 2020/7/14.
//  Copyright © 2020 Peter Luo. All rights reserved.
//

import Foundation

let py = LanguageLibrary(
    id: "py",
    keywords: Token.array(
        "and",
        "as",
        "asserte",
        "break",
        "class",
        "continue",
        "def",
        "del",
        "elif",
        "else",
        "except",
        "False",
        "finally",
        "for",
        "from",
        "global",
        "if",
        "import",
        "in",
        "is",
        "lambda",
        "None",
        "nonlocal",
        "not",
        "or",
        "pass",
        "raise",
        "return",
        "True",
        "try",
        "while",
        "with",
        "yield"
    ),
    types: Token.array(
    ),
    comments: Token.array(
        "#(.+)",
        requiresSeperatorStart: false,
        requiresSeperatorEnd: false
    ),
    numbers: Token.array(
        "[0-9]+",
        requiresSeperatorStart: false,
        requiresSeperatorEnd: false
    ),
    strings: Token.array(
        "'(.+)'",
        "\"(.+)\"",
        requiresSeperatorStart: false,
        requiresSeperatorEnd: false
    ),
    identifiers: Token.array(
        "print"
    )
)
