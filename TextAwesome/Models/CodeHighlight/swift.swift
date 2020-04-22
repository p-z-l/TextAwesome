//
//  swift.swift
//  TextAwesome
//
//  Created by Peter Luo on 2020/3/31.
//  Copyright © 2020 Peter Luo. All rights reserved.
//

import Foundation

private let swiftDict: [String: [String]] = [
	"id": ["swift"],
	"keywords": [
		"let ",
		"var ",
		"func ",
		"class ",
		"struct ",
		"protocol ",
		"extension ",
		"guard ",
		"private ",
		"fileprivate ",
		"private\\(set\\) ",
		"internal ",
		"public ",
		"static ",
		"dynamic ",
		"import ",
		"get ",
		"set ",
		"didSet ",
		"willSet ",
		"if ",
		"elseif ",
		"else ",
		"return ",
		"@IBOutlet ",
		"@IBAction ",
		"@objc ",
		"#selector",
		"self",
		"super",
		"weak ",
		"strong ",
		"lazy ",
		"override ",
	],
	"types": [
		"String",
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
	],
	"comments": [
		"//(.*)",
		"/\\*(.*)\\*/",
	],
	"numbers": [
		"0", "1", "2", "3", "4",
		"5", "6", "7", "8", "9", "true", "false", "nil",
	],
	"strings": [
		"\"(.+)\""
	],
]

internal func initializeSwiftLangDictionary() {
	langDictionaries.append(swiftDict)
}
