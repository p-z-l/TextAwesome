//
//  SyntaxThemeTableViewController.swift
//  TextAwesome
//
//  Created by Peter Luo on 2020/7/3.
//  Copyright © 2020 Peter Luo. All rights reserved.
//

import UIKit

class SyntaxThemeTableViewController: UITableViewController {

    @IBOutlet var themesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ThemesManager.themes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "ThemeCell")
        let representedTheme = ThemesManager.themes[indexPath.row]
        cell.backgroundColor = representedTheme.backgroundColor
        cell.textLabel?.textColor = representedTheme.textColor
        cell.textLabel?.text = representedTheme.id
        cell.textLabel?.font = Settings.fontStyle.uiFont
        cell.selectionStyle = .none
        cell.tintColor = representedTheme.keywordsColor
        if cell.textLabel?.text == Settings.syntaxThemeID {
            cell.accessoryType = .checkmark
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.selectInSection(indexPath)
        if let themeID = tableView.cellForRow(at: indexPath)?.textLabel?.text {
            Settings.syntaxThemeID = themeID
        }
    }
}
