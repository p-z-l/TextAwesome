//
//  DocumentViewController.swift
//  TextAwesome
//
//  Created by Peter Luo on 2020/3/29.
//  Copyright © 2020 Peter Luo. All rights reserved.
//

import UIKit

class DocumentViewController: UIViewController, UITextViewDelegate, UIPointerInteractionDelegate {

	// MARK: Properties

    @IBOutlet weak var titleBarView: UIView!
    
    @IBOutlet weak var documentTextView: UITextView!

	@IBOutlet weak var btDismiss: UIButton!

	@IBOutlet weak var btSearch: UIButton!

	@IBOutlet weak var btResignKeyboard: UIButton!

	@IBOutlet weak var nameLabel: UILabel!

	@IBOutlet weak var searchField: UITextField!

    @IBOutlet weak var seperatorView: UIView!
    
    private var searchBarIsShown = false

    private lazy var shouldSyntaxHighlight : Bool = {
        if !LibrariesManager.hasLibrary(of: self.document?.fileURL.pathExtension) {
            return false
        }
        if !Settings.enableSyntaxHighlight {
            return false
        }
        return true
    }()

	private var selectedSearchResultIndex: Int?

	var document: TextDocument?
    
    lazy var codeHighlighter = CodeHighlighter(
        fileExtension: document?.fileURL.pathExtension ?? "",
        themeName: Settings.syntaxThemeID
        )
    
    override var keyCommands: [UIKeyCommand]? {
        return [
            UIKeyCommand(
                title: "Find", action: #selector(toggleSearchField), input: "f",
                modifierFlags: .command),
            UIKeyCommand(
                title: "Close Document",
                action: #selector(dismissDocumentViewController), input: "w",
                modifierFlags: .command),
            UIKeyCommand(
                title: "Save Document", action: #selector(saveFile), input: "s",
                modifierFlags: .command),
            UIKeyCommand(
                title: "Escape",
                action: #selector(resignKeyboardTouchUpInside(_:)),
                input: UIKeyCommand.inputEscape, attributes: .hidden),
        ]
    }

	// MARK: ViewController lifecycle

	override func viewDidLoad() {
		super.viewDidLoad()

		// Cursor support
		if #available(iOS 13.4, *) {
			self.btDismiss.isPointerInteractionEnabled = true
			self.btSearch.isPointerInteractionEnabled = true
			self.btResignKeyboard.isPointerInteractionEnabled = true
		}

		// Access the document
        document?.open(completionHandler: { [self] (success) in
			if success {
				// Display the content of the document, e.g.:
				self.nameLabel.text = self.document?.fileURL.lastPathComponent
                
                
				let text = self.document?.userText
                self.documentTextView.text = text
                
                documentTextView.backgroundColor = Settings.syntaxTheme.backgroundColor.uiColor
                documentTextView.font = Settings.fontStyle.uiFont
                documentTextView.textColor = Settings.syntaxTheme.textColor.uiColor
                seperatorView.backgroundColor = Settings.syntaxTheme.textColor.uiColor
                titleBarView.backgroundColor = Settings.syntaxTheme.backgroundColor.uiColor
                
                if shouldSyntaxHighlight {
                    resetTextAttribute(stayOnCurrentPosition: false)
                }
                
			} else {
				print("Error opening Document.")
			}
		})

		self.documentTextView.delegate = self
		self.documentTextView.allowsEditingTextAttributes = true
        
        setupObservers()
        
        updateInterfaceStyle()
	}

	// MARK: Actions

	@IBAction func searchFieldEditingChanged(_ sender: UITextField) {
		self.textSearch()
	}

	@IBAction func searchFieldHitReturn(_ sender: UITextField) {
	}

	@IBAction @objc func dismissDocumentViewController() {
		self.saveFile()
		dismiss(animated: true) {
			self.document?.close(completionHandler: nil)
		}
	}

	@objc @IBAction func resignKeyboardTouchUpInside(_ sender: UIButton) {
		self.saveFile()
		self.documentTextView.resignFirstResponder()
//		self.searchField.resignFirstResponder()
		self.view.becomeFirstResponder()
	}

	@IBAction func btSearchTouchUpInside(_ sender: UIButton) {
		self.toggleSearchField()
	}

	@objc func toggleSearchField() {
		if searchBarIsShown {
			self.hideSearchField()
		} else {
			self.showSearchField()
		}
	}
    
    @objc private func updateInterfaceStyle() {
        self.overrideUserInterfaceStyle = Settings.interfaceStyle.uiUserInterfaceStyle
        self.documentTextView.keyboardAppearance = Settings.interfaceStyle.uiKeyboardAppearance
    }

	@objc private func keyboardDidChangeFrame(_ notification: Notification) {
        let keyboardHeight : CGFloat = {
            guard let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
                else { return 0 }
            return keyboardFrame.cgRectValue.height
        }()
        
        adjustTextViewContentInsetToFitKeyboard(distance: keyboardHeight)
	}
    
	@objc private func showSearchField() {
		searchBarIsShown = true
		self.upConstraint?.constant = 8
		UIView.animate(
			withDuration: 0.2, delay: 0,
			options: UIView.AnimationOptions.curveEaseInOut,
			animations: {
				self.view.layoutIfNeeded()
			}, completion: nil)
//		self.searchField.becomeFirstResponder()
		self.textSearch()
	}

	@objc func hideSearchField() {
		searchBarIsShown = false
		self.upConstraint?.constant = -40
		UIView.animate(
            withDuration: UIView.inheritedAnimationDuration,
            delay: 0,
			options: UIView.AnimationOptions.curveEaseInOut,
			animations: {
				self.view.layoutIfNeeded()
			}, completion: nil)
//		self.searchField.resignFirstResponder()
		self.resetTextAttribute()
		self.documentTextView.becomeFirstResponder()
		self.view.becomeFirstResponder()
	}

	// MARK: UITextViewDelegate
    
	func textViewDidEndEditing(_ textView: UITextView) {
		saveFile()
	}

	func textViewDidChange(_ textView: UITextView) {
		resetTextAttribute()
	}

	// MARK: Private methods

	private func adjustTextViewContentInsetToFitKeyboard(distance: CGFloat) {
		UIView.animate(withDuration: 0.1) {
			self.documentTextView.contentInset = UIEdgeInsets(
				top: 0, left: 0, bottom: distance, right: 0)
		}
		self.documentTextView.scrollIndicatorInsets =
			self.documentTextView.contentInset
	}

	@objc private func saveFile() {
		document?.userText = documentTextView.text
		if let url = document?.fileURL {
			document?.save(
				to: url, for: .forOverwriting,
				completionHandler: { (success: Bool) -> Void in

					if !success {
						print("Unable to saving document")
					}

				})
		}
		self.view.becomeFirstResponder()
	}

    @objc private func resetTextAttribute(stayOnCurrentPosition: Bool = true) {
        
        guard Settings.enableSyntaxHighlight && shouldSyntaxHighlight,
              let string = self.documentTextView.text else { return }
        
        let syntaxHighlightQueue = DispatchQueue(label: "syntax highlight")
        syntaxHighlightQueue.async { [self] in
            DispatchQueue.main.async {
                // Get cursor position
                let originalTextRange = documentTextView.selectedTextRange
                let originalRange = documentTextView.selectedRange
                let originalInset = documentTextView.contentInset
                
                let attributedText =  self.codeHighlighter.highlightedCode(for: string)
                self.documentTextView.attributedText = attributedText
                if stayOnCurrentPosition {
                    self.documentTextView.selectedTextRange = originalTextRange
                    self.documentTextView.scrollRangeToVisible(originalRange)
                    self.documentTextView.scrollIndicatorInsets = originalInset
                }
            }
        }

	}

	private func textSearch() {
		self.resetTextAttribute()
		let attributedText = NSMutableAttributedString(
			attributedString: self.documentTextView.attributedText)
//        attributedText.highlight(pattern: self.searchField.text ?? "", caseSensitive: Settings.caseSensitiveTextSearching)

		self.documentTextView.attributedText = attributedText
	}
    
    private func setupObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardDidChangeFrame(_:)),
            name: UIResponder.keyboardDidChangeFrameNotification,
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(updateInterfaceStyle),
            name: .InterfaceStyleChanged,
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(resetTextAttribute),
            name: .FontSizeChanged,
            object: nil)
    }

	@IBOutlet weak var upConstraint: NSLayoutConstraint!
}
