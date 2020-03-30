//
//  DocumentViewController.swift
//  TextAwesome
//
//  Created by Peter Luo on 2020/3/29.
//  Copyright © 2020 Peter Luo. All rights reserved.
//

import UIKit

class DocumentViewController: UIViewController, UITextViewDelegate {
    
    // MARK: Definitions
    
    @IBOutlet weak var documentNameLabel: UILabel!
    
    @IBOutlet weak var documentTextView: UITextView!
    
    @IBOutlet weak var documentTextViewBottom: NSLayoutConstraint!
    
    var document: TextDocument?
    
    // MARK: ViewController lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Access the document
        document?.open(completionHandler: { (success) in
            if success {
                // Display the content of the document, e.g.:
                self.documentNameLabel.text = self.document?.fileURL.lastPathComponent
                self.documentTextView.text = self.document?.userText
            } else {
                print("Error opening Document.")
            }
        })
        
        self.documentTextView.delegate = self
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(_:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
        self.setupSettings()
    }
    
    // MARK: Actions
    
    @IBAction func dismissDocumentViewController() {
        self.saveFile()
        dismiss(animated: true) {
            self.document?.close(completionHandler: nil)
        }
    }
    
    @IBAction func resignKeyboardTouchUpInside(_ sender: UIButton) {
        self.saveFile()
        self.documentTextView.resignFirstResponder()
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        self.resetTextViewFrame()
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            self.documentTextViewBottom.constant -= keyboardHeight
            
            self.animateTextView(textView: self.documentTextView, distance: keyboardHeight)
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        self.resetTextViewFrame()
    }
    
    // MARK: UITextViewDelegate
    
    func textViewDidEndEditing(_ textView: UITextView) {
        self.saveFile()
    }
    
    // MARK: Private methods
    
    private func resetTextViewFrame() {
        self.documentTextViewBottom.constant = 0
        self.documentTextView.layoutIfNeeded()
    }
    
    private func saveFile() {
        document?.userText = documentTextView.text
        if let url = document?.fileURL {
            document?.save(to: url, for: .forOverwriting, completionHandler:
                { (success: Bool) -> Void in
                
                if !success {
                    print("Unable to saving document")
                }
                
            })
        }
    }
    
    private func animateTextView(textView: UITextView, distance: CGFloat) {
        UIView.animate(withDuration: 0.1) {
            textView.frame = CGRect(x: textView.frame.minX,
                                    y: textView.frame.minY,
                                    width: textView.frame.width,
                                    height: textView.frame.height - distance)
        }
    }
    
    private func setupSettings() {
        guard let font = Constants.fontDict[Settings.fontStyle] else { return }
        self.documentTextView.font = font
    }
}
