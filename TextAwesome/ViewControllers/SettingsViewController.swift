//
//  SettingsViewController.swift
//  TextAwesome
//
//  Created by Peter Luo on 2020/3/30.
//  Copyright © 2020 Peter Luo. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {
    
    @IBOutlet weak var fontSizeSlider: UISlider!
    
    let switchCaseSensitive = UISwitch()
    
    let switchEnableSyntaxHighlight = UISwitch()
    
    // MARK: Actions
    
    @IBAction func btDownTouchUpInside(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func fontSizeSliderChanged(_ sender: UISlider) {
        let size = Int(sender.value)
        Settings.fontSize = CGFloat(size)
        
        self.updateCells()
    }
    
    // MARK: ViewController lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.fontSizeSlider.value = Float(Settings.fontSize)
        switchCaseSensitive.setOn(Settings.caseSensitiveTextSearching, animated: true)
        switchEnableSyntaxHighlight.setOn(Settings.syntaxHighlight, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        Settings.caseSensitiveTextSearching = switchCaseSensitive.isOn
        Settings.syntaxHighlight = switchEnableSyntaxHighlight.isOn
        
        print(Settings.syntaxHighlight)
    }
    
    // MARK: TableView
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        updateCells()
        self.setCellAccesoryView(atRow: 0, section: 2, view: switchCaseSensitive)
        self.setCellAccesoryView(atRow: 0, section: 3, view: switchEnableSyntaxHighlight)
        return 4
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
        updateCells()
    }
    
    // MARK: Private methods
    
    private func updateCells() {
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
        
        // Update font size display
        let fontSizeText = "Font size: \(Settings.fontSize)"
        self.tableView.cellForRow(at: IndexPath(row: 0, section: 1))?.textLabel?.text = fontSizeText
    }
    
    private func setCellSelection(atRow row: Int, section: Int, selected isSelected: Bool) {
        let indexPath = IndexPath(row: row, section: section)
        if isSelected {
            tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
        } else {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    private func setCellAccesoryView(atRow row:Int, section: Int, view: UIView) {
        let indexPath = IndexPath(row: row, section: section)
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryView = view
        cell?.addSubview(view)
    }
}
