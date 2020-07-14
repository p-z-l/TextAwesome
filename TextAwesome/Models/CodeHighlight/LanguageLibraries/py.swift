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
    keywords: Keyword.array(
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
    types: Keyword.array(
    ),
    comments: Keyword.array(
        "#(.+)",
        requiresSeperatorStart: false,
        requiresSeperatorEnd: false
    ),
    numbers: Keyword.array(
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
    ),
    strings: Keyword.array(
        "'(.+)'",
        "\"(.+)\"",
        requiresSeperatorStart: false,
        requiresSeperatorEnd: false
    ),
    identifiers: Keyword.array(
        "print"
    )
)
