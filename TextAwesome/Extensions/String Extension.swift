//
//  String Extension.swift
//  TextAwesome
//
//  Created by Peter Luo on 2020/3/31.
//  Copyright © 2020 Peter Luo. All rights reserved.
//

import Foundation

extension String {
    func getCharOfIndex(_ index: Int) -> Character {
        let characterLocationIndex = self.index(self.startIndex, offsetBy: index)
        return self[characterLocationIndex]
    }
}
