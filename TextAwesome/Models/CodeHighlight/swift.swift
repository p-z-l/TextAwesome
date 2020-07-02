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
        Keyword("import"),
        Keyword("let"),
        Keyword("var"),
        Keyword("if"),
        Keyword("switch"),
        Keyword("func"),
        Keyword("struct"),
        Keyword("class"),
        Keyword("protocol"),
        Keyword("enum"),
        Keyword("private"),
        Keyword("fileprivate"),
        Keyword("private\\(set\\)"),
        Keyword("internal"),
        Keyword("open"),
        Keyword("public"),
        Keyword("static"),
        Keyword("dynamic"),
        Keyword("optional"),
        Keyword("try"),
        Keyword("get"),
        Keyword("set"),
        Keyword("didSet"),
        Keyword("willSet"),
        Keyword("@IBOutlet"),
        Keyword("@IBAction"),
        Keyword("@objc"),
        Keyword("#selector"),
        Keyword("required"),
        Keyword("convenience"),
        Keyword("init"),
        Keyword("deinit"),
        Keyword("as"),
        Keyword("some"),
        Keyword("self"),
        Keyword("mutating"),
    ],
    types: [
        Keyword("Array"),
        Keyword("Data"),
        Keyword("Date"),
        Keyword("Dictionary"),
        Keyword("String"),
        Keyword("Character"),
        Keyword("Int"),
        Keyword("Int8"),
        Keyword("Int16"),
        Keyword("Int32"),
        Keyword("Int64"),
        Keyword("Float"),
        Keyword("Float8"),
        Keyword("Float16"),
        Keyword("Float32"),
        Keyword("Float64"),
        Keyword("Double"),
        Keyword("Bool"),
    ], comments: [
        Keyword("//(.+)")
        .requiresSeperator(start: false, end: false),
        Keyword("/\\*(.*)\\*/")
        .requiresSeperator(start: false, end: false),
    ], numbers: [
        Keyword("0")
        .requiresSeperator(start: false, end: false),
        Keyword("1")
        .requiresSeperator(start: false, end: false),
        Keyword("2")
        .requiresSeperator(start: false, end: false),
        Keyword("3")
        .requiresSeperator(start: false, end: false),
        Keyword("4")
        .requiresSeperator(start: false, end: false),
        Keyword("5")
        .requiresSeperator(start: false, end: false),
        Keyword("6")
        .requiresSeperator(start: false, end: false),
        Keyword("7")
        .requiresSeperator(start: false, end: false),
        Keyword("8")
        .requiresSeperator(start: false, end: false),
        Keyword("9")
        .requiresSeperator(start: false, end: false),
    ], strings: [
        Keyword("\"(.+)\"")
        .requiresSeperator(start: false, end: false),
    ]
)

