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
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateInterfaceStyle), name: .InterfaceStyleChanged, object: nil)
        
        updateInterfaceStyle()
        
        updateCells()
        
        // Setup font style cells
        tableView.cellForRow(at: IndexPath(row: 0, section: 0))?.textLabel?.font = UIFont.SFMono(ofSize: UIFont.labelFontSize)
        tableView.cellForRow(at: IndexPath(row: 1, section: 0))?.textLabel?.font = UIFont.NY(ofSize: UIFont.labelFontSize)
        tableView.cellForRow(at: IndexPath(row: 2, section: 0))?.textLabel?.font = UIFont.SF(ofSize: UIFont.labelFontSize)
	}

	override func viewWillDisappear(_ animated: Bool) {
		Settings.caseSensitiveTextSearching = switchCaseSensitive.isOn
		Settings.enableSyntaxHighlight = switchEnableSyntaxHighlight.isOn
	}

	// MARK: TableView

	override func numberOfSections(in tableView: UITableView) -> Int {
		self.setCellAccesoryView(atRow: 0, section: 3, view: switchCaseSensitive)
		self.setCellAccesoryView(atRow: 0, section: 4, view: switchEnableSyntaxHighlight)
		return 5
	}

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
		switch indexPath.section {
        case 0:
            Settings.fontStyle = FontStyle(rawValue: indexPath.row) ?? .monoSpace
        case 2:
            Settings.interfaceStyle = InterfaceStyle(rawValue: indexPath.row) ?? .system
        case 4:
            if indexPath.row == 1 {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let themeSelectionVC = storyboard.instantiateViewController(identifier: "ThemeSelection")
                self.navigationController?.pushViewController(themeSelectionVC, animated: true)
            }
		default:
			return
		}
		updateCells()
	}

	// MARK: Private methods
    
    @objc private func updateInterfaceStyle() {
        self.overrideUserInterfaceStyle = Settings.interfaceStyle.uiUserInterfaceStyle
        self.navigationController?.overrideUserInterfaceStyle = Settings.interfaceStyle.uiUserInterfaceStyle
    }
    
    @objc private func updateSyntaxTheme() {
        updateCells()
    }

	private func updateCells() {

        // Update font styles
        tableView.selectInSection(row: Settings.fontStyle.rawValue, section: 0)
    
        // Update interface styles
        tableView.selectInSection(row: Settings.interfaceStyle.rawValue, section: 2)

		// Update font size display
        if let fontSizeCell = self.tableView.cellForRow(at: IndexPath(row: 0, section: 1)),
           fontSizeCell.textLabel != nil {
            let fontSizeText = "\(Settings.fontSize)pt"
            let displayFont = UIFont(descriptor: fontSizeCell.textLabel!.font.fontDescriptor, size: Settings.fontSize)
            fontSizeCell.textLabel?.text = fontSizeText
            fontSizeCell.textLabel?.font = displayFont
        }
	}

	private func setCellAccesoryView(atRow row: Int, section: Int, view: UIView) {
		let indexPath = IndexPath(row: row, section: section)
		let cell = tableView.cellForRow(at: indexPath)
		cell?.accessoryView = view
		cell?.addSubview(view)
	}
}
