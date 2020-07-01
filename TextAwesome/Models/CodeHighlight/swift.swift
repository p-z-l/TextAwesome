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
    keywords: [
        "import ",
        "let ",
        "var ",
        "if ",
        "switch ",
        "func ",
        "struct ",
        "class ",
        "protocol ",
        "enum ",
        "private ",
        "fileprivate ",
        "private\\(set\\) ",
        "internal ",
        "open ",
        "public ",
        "static ",
        "dynamic ",
        "optional ",
        "try ",
        "get ",
        "set ",
        "didSet ",
        "willSet ",
        "@IBOutlet ",
        "@IBAction ",
        "@objc ",
        "#selector",
        "required ",
        "convenience ",
        "init",
        "deinit",
        "as",
    ],
    types: [
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
    ], comments: [
        "//(.+)",
        "/\\*(.*)\\*/"
    ], numbers: [
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
    ], strings: [
        "\"(.+)\"",
    ]
)

