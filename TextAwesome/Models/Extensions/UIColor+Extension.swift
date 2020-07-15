//
//  UIColor+Extension.swift
//  TextAwesome
//
//  Created by Peter Luo on 2020/7/15.
//  Copyright © 2020 Peter Luo. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(_ hex: Int) {
        self.init(
            red: CGFloat((hex >> 16) & 0xFF)/255,
            green: CGFloat((hex >> 8) & 0xFF)/255,
            blue: CGFloat(hex & 0xFF)/255,
            alpha: 1.0
        )
    }
    
    convenience init(_ hex: Int, alpha: CGFloat) {
        self.init(
            red: CGFloat((hex >> 16) & 0xFF)/255,
            green: CGFloat((hex >> 8) & 0xFF)/255,
            blue: CGFloat(hex & 0xFF)/255,
            alpha: alpha
        )
    }
    
}
