//
//  css.swift
//  TextAwesome
//
//  Created by Peter Luo on 2020/7/15.
//  Copyright © 2020 Peter Luo. All rights reserved.
//

import Foundation

let css = TokenLibrary(
    id: "css",
    keywords: [
        Token("(.+) ?\\{", requiresSepertorStart: false, requiresSeperatorEnd: false, endIgnorance: 1)
    ],
    types: nil,
    comments: [
        Token("/\\*(.*)\\*/", requiresSepertorStart: false, requiresSeperatorEnd: false)
    ],
    numbers: [
        Token("[0-9]", requiresSepertorStart: false, requiresSeperatorEnd: false)
    ],
    strings: [
        Token("\"(.*)\"", requiresSepertorStart: false, requiresSeperatorEnd: false)
    ],
    identifiers: [
        Token("#[0-9A-Fa-f]+")
    ]
)
