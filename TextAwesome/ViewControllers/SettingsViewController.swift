//
//  SettingsViewController.swift
//  TextAwesome
//
//  Created by Peter Luo on 2020/3/30.
//  Copyright © 2020 Peter Luo. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {
    
    // MARK: Actions
    @IBAction func btDownTouchUpInside(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: ViewController lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: TableView
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        updateCellSelections()
        return 1
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                Settings.fontStyle = .monoSpace
            case 1:
                Settings.fontStyle = .serif
            case 2:
                Settings.fontStyle = .sansSerif
            default:
                return
            }
        default:
            return
        }
        updateCellSelections()
    }
    
    // MARK: Private methods
    
    private func updateCellSelections() {
        switch Settings.fontStyle {
        case .monoSpace:
            setCellSelection(atRow: 0, section: 0, selected: true)
            setCellSelection(atRow: 1, section: 0, selected: false)
            setCellSelection(atRow: 2, section: 0, selected: false)
        case .serif:
            setCellSelection(atRow: 0, section: 0, selected: false)
            setCellSelection(atRow: 1, section: 0, selected: true)
            setCellSelection(atRow: 2, section: 0, selected: false)
        case .sansSerif:
            setCellSelection(atRow: 0, section: 0, selected: false)
            setCellSelection(atRow: 1, section: 0, selected: false)
            setCellSelection(atRow: 2, section: 0, selected: true)
        }
    }
    
    private func setCellSelection(atRow row: Int, section: Int, selected isSelected: Bool) {
        let indexPath = IndexPath(row: row, section: section)
        if isSelected {
            tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
        } else {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
}
