//
//  DocumentViewController.swift
//  TextAwesome
//
//  Created by Peter Luo on 2020/3/29.
//  Copyright © 2020 Peter Luo. All rights reserved.
//

import UIKit

class DocumentViewController: UIViewController {
    
    @IBOutlet weak var documentNameLabel: UILabel!
    
    @IBOutlet weak var documentText: UITextView!
    
    var document: Document?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Access the document
        document?.open(completionHandler: { (success) in
            if success {
                // Display the content of the document, e.g.:
                self.documentNameLabel.text = self.document?.fileURL.lastPathComponent
                self.documentText.text = self.document?.userText
            } else {
                print("Error opening Document.")
            }
        })
        
        
    }
    
    @IBAction func dismissDocumentViewController() {
        self.updateFileContent()
        self.saveFile()
        dismiss(animated: true) {
            self.document?.close(completionHandler: nil)
        }
    }
    
    private func saveFile() {
        if let url = document?.fileURL {
            document?.save(to: url, for: .forOverwriting, completionHandler:
                { (success: Bool) -> Void in
                
                if success {
                    print("File saved")
                } else {
                    print("Error saving file")
                }
                
            })
        }
    }
    
    private func updateFileContent() {
        document?.userText = documentText.text
    }
}
