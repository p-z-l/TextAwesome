//
//  html.swift
//  TextAwesome
//
//  Created by Peter Luo on 2020/7/14.
//  Copyright © 2020 Peter Luo. All rights reserved.
//

import Foundation

let html = LanguageLibrary(
    id: "html",
    keywords: [
        Keyword("<[a-zA-Z0-9]+", requiresSepertorStart: false, startIgnorance: 1),
        Keyword("</[a-zA-Z0-9]+", requiresSepertorStart: false, startIgnorance: 2)
    ],
    types: nil,
    comments: [
        Keyword("<!--(.*)-->", requiresSepertorStart: false, requiresSeperatorEnd: false)
    ],
    numbers: nil,
    strings: [
        Keyword("\"(.*)\"")
    ],
    identifiers: [
        Keyword("[a-zA-Z0-9]+=", requiresSepertorStart: false, requiresSeperatorEnd: false, endIgnorance: 1)
    ]
)
