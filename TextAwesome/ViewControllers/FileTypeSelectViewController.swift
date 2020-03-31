//
//  FileTypeSelectViewController.swift
//  TextAwesome
//
//  Created by Peter Luo on 2020/3/31.
//  Copyright © 2020 Peter Luo. All rights reserved.
//

import UIKit

class FileTypeTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dismiss(animated: true, completion: nil)
        
        let selectedFiletype = Constants.fileTypes[indexPath.row]
        
        if let handler = selectionHandler {
            handler(selectedFiletype)
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    private var selectionHandler: ((FileType) -> Void)?
    
    internal func didSelectFileType(_ handler: @escaping (FileType) -> Void) {
        self.selectionHandler = handler
    }
}
