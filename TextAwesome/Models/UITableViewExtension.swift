//
//  UITableViewExtension.swift
//  TextAwesome
//
//  Created by Peter Luo on 2020/7/3.
//  Copyright © 2020 Peter Luo. All rights reserved.
//

import UIKit

extension UITableView {
    
    func selectInSection(_ indexPathToSelect: IndexPath) {
        for row in 0..<self.numberOfRows(inSection: indexPathToSelect.section) {
            let indexPath = IndexPath(row: row, section: indexPathToSelect.section)
            if indexPath.row == indexPathToSelect.row {
                self.cellForRow(at: indexPath)?.accessoryType = .checkmark
            } else {
                self.cellForRow(at: indexPath)?.accessoryType = .none
            }
        }
    }
    
    func selectInSection(row: Int, section: Int) {
        let indexPath = IndexPath(row: row, section: section)
        self.selectInSection(indexPath)
    }
    
}
