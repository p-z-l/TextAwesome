//
//  html.swift
//  TextAwesome
//
//  Created by Peter Luo on 2020/7/14.
//  Copyright © 2020 Peter Luo. All rights reserved.
//

import Foundation

let html = TokenLibrary(
    id: "html",
    keywords: [
        Token("<[a-zA-Z0-9]+", requiresSepertorStart: false, startIgnorance: 1),
        Token("</[a-zA-Z0-9]+", requiresSepertorStart: false, startIgnorance: 2)
    ],
    types: nil,
    comments: [
        Token("<!--(.*)-->", requiresSepertorStart: false, requiresSeperatorEnd: false)
    ],
    numbers: nil,
    strings: [
        Token("\"(.*)\"")
    ],
    identifiers: [
        Token("[a-zA-Z0-9]+=", requiresSepertorStart: false, requiresSeperatorEnd: false, endIgnorance: 1)
    ]
)
