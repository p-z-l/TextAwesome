//
//  DocumentViewController.swift
//  TextAwesome
//
//  Created by Peter Luo on 2020/3/29.
//  Copyright © 2020 Peter Luo. All rights reserved.
//

import UIKit

class DocumentViewController: UIViewController, UITextViewDelegate, UIPointerInteractionDelegate {

	// MARK: Definitions

	@IBOutlet weak var fakeNavBarView: UIVisualEffectView!

	@IBOutlet weak var documentTextView: UITextView!

	@IBOutlet weak var btDismiss: UIButton!

	@IBOutlet weak var btSearch: UIButton!

	@IBOutlet weak var btResignKeyboard: UIButton!

	@IBOutlet weak var nameLabel: UILabel!

	@IBOutlet weak var searchField: UITextField!

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

	// MARK: ViewController lifecycle

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
                
				self.resetTextAttribute()
			} else {
				print("Error opening Document.")
			}
		})

		self.documentTextView.delegate = self
		self.documentTextView.allowsEditingTextAttributes = true

		NotificationCenter.default.addObserver(
			self,
			selector: #selector(keyboardWillShow(_:)),
			name: UIResponder.keyboardWillShowNotification,
			object: nil)
		NotificationCenter.default.addObserver(
			self,
			selector: #selector(keyboardWillHide(_:)),
			name: UIResponder.keyboardWillHideNotification,
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
        
        updateInterfaceStyle()
        
        documentTextView.backgroundColor = Settings.syntaxTheme.backgroundColor.uiColor
        if shouldSyntaxHighlight {
            resetTextAttribute()
        } else {
            documentTextView.font = Settings.fontStyle.uiFont
            documentTextView.textColor = Settings.syntaxTheme.textColor.uiColor
        }
        
        resetTextViewContentInset(ignoreStatusBar: true, animated: false)
        documentTextView.scrollRangeToVisible(
            NSRange(location: 0, length: 0))
	}

	// MARK: Actions

	@IBAction func searchFieldEditingChanged(_ sender: UITextField) {
		self.textSearch()
	}

	@IBAction func searchFieldHitReturn(_ sender: UITextField) {
		self.selectNextTextSearchResult()
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
		self.searchField.resignFirstResponder()
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

	@objc private func keyboardWillShow(_ notification: Notification) {
		self.resetTextViewContentInset()
		if let keyboardFrame: NSValue =
			notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey]
			as? NSValue
		{
			let keyboardRectangle = keyboardFrame.cgRectValue
			let keyboardHeight = keyboardRectangle.height

			self.adjustTextViewContentInsetToFitKeyboard(
				distance: keyboardHeight)
		}
	}

	@objc private func keyboardWillHide(_ notification: Notification) {
		self.resetTextViewContentInset()
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
		self.searchField.becomeFirstResponder()
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
		self.searchField.resignFirstResponder()
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

    private func resetTextViewContentInset(ignoreStatusBar: Bool = false, animated: Bool = true) {
        let top : CGFloat = {
            if ignoreStatusBar {
                return self.fakeNavBarView.frame.height
            } else {
                let safeAreaTopMargin = UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0
                return self.fakeNavBarView.frame.height - safeAreaTopMargin
            }
        }()
        let animationDuration : TimeInterval = {
            if animated {
                return UIView.inheritedAnimationDuration
            } else {
                return 0.0
            }
        }()
		UIView.animate(withDuration: animationDuration) {
			self.documentTextView.contentInset = UIEdgeInsets(
				top: top,
                left: 0,
                bottom:0,
                right: 0
            )
		}
		documentTextView.scrollIndicatorInsets = documentTextView.contentInset
	}

	private func adjustTextViewContentInsetToFitKeyboard(distance: CGFloat) {
		let top = self.fakeNavBarView.frame.height
		UIView.animate(withDuration: 0.1) {
			self.documentTextView.contentInset = UIEdgeInsets(
				top: top, left: 0, bottom: distance, right: 0)
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

	@objc private func resetTextAttribute() {
        
        guard Settings.enableSyntaxHighlight && shouldSyntaxHighlight,
              let string = self.documentTextView.text else { return }
        
		// Get cursor position
		let selectedTextRange = documentTextView.selectedTextRange
		let selectedRange = documentTextView.selectedRange
        
        var attributedText = NSAttributedString(string: string)
        attributedText = codeHighlighter.highlightedCode(for: string)
		documentTextView.attributedText = attributedText
		documentTextView.selectedTextRange = selectedTextRange
		documentTextView.scrollRangeToVisible(selectedRange)

		documentTextView.scrollIndicatorInsets = self.documentTextView.contentInset
	}

	private func textSearch() {
		self.resetTextAttribute()
		let attributedText = NSMutableAttributedString(
			attributedString: self.documentTextView.attributedText)
        attributedText.highlight(pattern: self.searchField.text ?? "", caseSensitive: Settings.caseSensitiveTextSearching)

		self.documentTextView.attributedText = attributedText
	}

	private func selectNextTextSearchResult() {

		guard self.searchBarIsShown else { return }

		self.resetTextAttribute()
		self.textSearch()
        let ranges = self.documentTextView.attributedText.string.rangesOfPattern(
            self.searchField.text ?? "",
            caseSensitive: Settings.caseSensitiveTextSearching)
		guard !ranges.isEmpty else { return }

		var rangeToSelect = ranges.first!

		if self.selectedSearchResultIndex != nil {
			self.selectedSearchResultIndex! += 1
			if self.selectedSearchResultIndex! >= ranges.count {
				self.selectedSearchResultIndex = 0
			}
			let range = ranges[self.selectedSearchResultIndex!]
			rangeToSelect = range
		} else {
			self.selectedSearchResultIndex = 0
		}

		self.documentTextView.selectedRange = rangeToSelect
		let attributedString = NSMutableAttributedString(
			attributedString: documentTextView.attributedText)
		attributedString.addAttributes(
			[
				NSAttributedString.Key.backgroundColor: UIColor.red
			],
			range: rangeToSelect)
		documentTextView.attributedText = attributedString
		self.documentTextView.scrollRangeToVisible(rangeToSelect)
	}

	@IBOutlet weak var upConstraint: NSLayoutConstraint!
}
