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

		self.fontSizeSlider.value = Float(Settings.fontSize)
		switchCaseSensitive.setOn(Settings.caseSensitiveTextSearching, animated: true)
		switchEnableSyntaxHighlight.setOn(Settings.enableSyntaxHighlight, animated: true)
        
        updateCells()
	}

	override func viewWillDisappear(_ animated: Bool) {
		Settings.caseSensitiveTextSearching = switchCaseSensitive.isOn
		Settings.enableSyntaxHighlight = switchEnableSyntaxHighlight.isOn
	}

	// MARK: TableView

	override func numberOfSections(in tableView: UITableView) -> Int {
		updateCells()
		self.setCellAccesoryView(atRow: 0, section: 2, view: switchCaseSensitive)
		self.setCellAccesoryView(atRow: 0, section: 3, view: switchEnableSyntaxHighlight)
		return 5
	}

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		switch indexPath.section {
        case 0:
            Settings.fontStyle = FontStyle(rawValue: indexPath.row) ?? .monoSpace
        case 4:
            Settings.interfaceStyle = InterfaceStyle(rawValue: indexPath.row) ?? .system
		default:
			return
		}
		updateCells()
	}
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        updateCells()
    }

	// MARK: Private methods

	private func updateCells() {
        
        // Update font styles
        selectRow(Settings.fontStyle.rawValue, forSection: 0)
        
        // Update interface styles
        selectRow(Settings.interfaceStyle.rawValue, forSection: 4)

		// Update font size display
		let fontSizeText = "Font size: \(Settings.fontSize)"
		self.tableView.cellForRow(at: IndexPath(row: 0, section: 1))?.textLabel?.text = fontSizeText
	}
    
    private func selectRow(_ row: Int, forSection section: Int) {
        var indexPaths = [IndexPath]()
        for cell in tableView.visibleCells {
            guard let indexPath = tableView.indexPath(for: cell) else { continue }
            if indexPath.section == section {
                indexPaths.append(indexPath)
            }
        }
        for indexPath in indexPaths {
            if indexPath.row == row {
                tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
            } else {
                tableView.deselectRow(at: indexPath, animated: true)
            }
        }
    }

	private func setCellAccesoryView(atRow row: Int, section: Int, view: UIView) {
		let indexPath = IndexPath(row: row, section: section)
		let cell = tableView.cellForRow(at: indexPath)
		cell?.accessoryView = view
		cell?.addSubview(view)
	}
}
