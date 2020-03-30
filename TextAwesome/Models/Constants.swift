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
    static let fontTypeKey = "TextAwesome_FontType"
    
    static let fontDict : [FontStyle:UIFont?] = [
        .monoSpace: UIFont(name: "Menlo", size: 18),
        .serif: UIFont(name: "Helvetica Neue", size: 18),
        .sansSerif: UIFont(name: "Times New Roman", size: 18)
    ]
}
