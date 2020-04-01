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
    
    @IBOutlet weak var fakeNavBarView: UIVisualEffectView!
    
    @IBOutlet weak var documentTextView: UITextView!
    
    @IBOutlet weak var btDismiss: UIButton!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var searchField: UITextField!
    
    private var searchBarIsShown = false
    
    var document: TextDocument?
    
    // MARK: ViewController lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Access the document
        document?.open(completionHandler: { (success) in
            if success {
                // Display the content of the document, e.g.:
                self.nameLabel.text = self.document?.fileURL.lastPathComponent
                
                let text = self.document?.userText
                self.documentTextView.attributedText = NSAttributedString(string: text ?? "")
                
                self.resetTextAttribute()
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
        
        self.resetTextViewContentInset()
    }
    
    // MARK: Actions
    
    @IBAction func searchFieldEditingChanged(_ sender: UITextField) {
        self.textSearch(caseSensitive: false)
    }
    
    @IBAction func searchFieldHitReturn(_ sender: UITextField) {
        self.searchField.resignFirstResponder()
    }
    
    @IBAction func dismissDocumentViewController() {
        self.saveFile()
        dismiss(animated: true) {
            self.document?.close(completionHandler: nil)
        }
    }
    
    @IBAction func resignKeyboardTouchUpInside(_ sender: UIButton) {
        self.saveFile()
        self.documentTextView.resignFirstResponder()
        self.searchField.resignFirstResponder()
    }
    
    @IBAction func btSearchTouchUpInside(_ sender: UIButton) {
        if searchBarIsShown {
            self.hideSearchField()
            self.resetTextAttribute()
        } else {
            self.showSearchField()
            self.textSearch(caseSensitive: false)
        }
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        self.resetTextViewContentInset()
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            self.adjustTextViewContentInset(distance: keyboardHeight)
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        self.resetTextViewContentInset()
    }
    
    // MARK: UITextViewDelegate
    
    func textViewDidEndEditing(_ textView: UITextView) {
        self.saveFile()
    }
    
    func textViewDidChange(_ textView: UITextView) {
        self.resetTextAttribute()
    }
    
    // MARK: Private methods
    
    private func resetTextViewContentInset() {
        let safeAreaTopMargin = UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 0
        let top = self.fakeNavBarView.frame.height - safeAreaTopMargin
        UIView.animate(withDuration: 0.1) {
            self.documentTextView.contentInset = UIEdgeInsets(top: top, left: 0, bottom: 0, right: 0)
        }
        self.documentTextView.scrollIndicatorInsets = self.documentTextView.contentInset
    }
    
    private func adjustTextViewContentInset(distance: CGFloat) {
        let top = self.fakeNavBarView.frame.height
        UIView.animate(withDuration: 0.1) {
            self.documentTextView.contentInset = UIEdgeInsets(top: top, left: 0, bottom: distance, right: 0)
        }
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
    
    private func setupSettings() {
        
        guard let fontName = Constants.fontDict[Settings.fontStyle] else { return }
        let font = UIFont(name: fontName, size: Settings.fontSize)
        
        self.documentTextView.font = font
        self.resetTextAttribute()
    }
    
    private func resetTextAttribute() {
        // Get cursor position
        var cursorPositionStart: UITextPosition?
        if let cursorPosition = documentTextView.selectedTextRange?.start {
            cursorPositionStart = cursorPosition
        }
        var cursorPositionEnd: UITextPosition?
        if let cursorPosition = documentTextView.selectedTextRange?.end {
            cursorPositionEnd = cursorPosition
        }
        
        guard let string = self.documentTextView.text else { return }
        let textColor = UIColor(named: "Text Color")
        let font = UIFont(name: Constants.fontDict[Settings.fontStyle]!, size: Settings.fontSize)
        var attributedText = NSAttributedString(string: string, attributes: [
            NSAttributedString.Key.foregroundColor: textColor!,
            NSAttributedString.Key.font: font!
        ])
        let fileExtension = self.document!.fileURL.pathExtension
        attributedText = CodeHighlighter.highlight(attributedText, fileExtension: fileExtension)
        self.documentTextView.attributedText = attributedText
        
        if cursorPositionStart != nil && cursorPositionEnd != nil {
            self.documentTextView.selectedTextRange = documentTextView.textRange(from: cursorPositionStart!, to: cursorPositionEnd!)
        }
    }
    
    private func textSearch(caseSensitive: Bool) {
        self.resetTextAttribute()
        let attributedText = NSMutableAttributedString(attributedString: self.documentTextView.attributedText)
        Utils.attributeMatchingResults(attributedText, pattern: self.searchField.text ?? "", caseSensitive: caseSensitive, attributes: [
            NSAttributedString.Key.backgroundColor: UIColor.yellow,
            NSAttributedString.Key.foregroundColor: UIColor.darkText
        ])
        
        self.documentTextView.attributedText = attributedText
    }
    
    @IBOutlet weak var upConstraint: NSLayoutConstraint!
    
    private func showSearchField() {
        searchBarIsShown = true
        self.upConstraint?.constant = 8
        UIView.animate(withDuration: 0.2, delay: 0, options: UIView.AnimationOptions.curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
        self.searchField.becomeFirstResponder()
    }
    
    private func hideSearchField() {
        searchBarIsShown = false
        self.upConstraint?.constant = -40
        UIView.animate(withDuration: 0.2, delay: 0, options: UIView.AnimationOptions.curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
        self.searchField.resignFirstResponder()
    }
}
