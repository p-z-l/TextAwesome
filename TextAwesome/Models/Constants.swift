//
//  Constants.swift
//  TextAwesome
//
//  Created by Peter Luo on 2020/3/30.
//  Copyright © 2020 Peter Luo. All rights reserved.
//

import UIKit

class Constants {
    // UserDefault Keys
    static let fontStyleKey = "TextAwesome_FontStyle"
    static let fontSizeKey = "TextAwesome_FontSize"
    
    static let fontDict : [FontStyle:String] = [
        .monoSpace: "Menlo",
        .serif: "Helvetica Neue",
        .sansSerif: "Times New Roman"
    ]
    
    static let fileTypes = [
        FileType(defaultName: "New Plain Text File", fileExtension: "txt"),
        FileType(defaultName: "New Swift File", fileExtension: "swift"),
        FileType(defaultName: "New Python File", fileExtension: "py"),
        FileType(defaultName: "New HTML File", fileExtension: "html"),
        FileType(defaultName: "New CSS File", fileExtension: "css"),
        FileType(defaultName: "New JavaScript File", fileExtension: "js"),
        FileType(defaultName: "New Java File", fileExtension: "java"),
        FileType(defaultName: "New Markdown File", fileExtension: "md"),
        FileType(defaultName: "New C File", fileExtension: "c"),
        FileType(defaultName: "New C++ File", fileExtension: "cpp"),
        FileType(defaultName: "New Objective-C File", fileExtension: "m"),
        FileType(defaultName: "New Header File", fileExtension: "h"),
    ]
    
    static let lowToUpCase : [Character:Character] = [
        "a":"A","b":"B","c":"C","d":"D",
        "e":"E","f":"F","g":"G","h":"H",
        "i":"I","j":"J","k":"K","l":"L",
        "m":"M","n":"N","o":"O","p":"P",
        "q":"Q","r":"R","s":"S","t":"T",
        "u":"U","v":"V","w":"W","x":"X",
        "y":"Y","z":"Z",
    ]
}
