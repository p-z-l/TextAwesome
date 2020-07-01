//
//  DocumentViewController.swift
//  TextAwesome
//
//  Created by Peter Luo on 2020/3/29.
//  Copyright © 2020 Peter Luo. All rights reserved.
//

import UIKit

class DocumentViewController: UIViewController, UITextViewDelegate,
	UIPointerInteractionDelegate
{

	// MARK: Definitions

	@IBOutlet weak var fakeNavBarView: UIVisualEffectView!

	@IBOutlet weak var documentTextView: UITextView!

	@IBOutlet weak var btDismiss: UIButton!

	@IBOutlet weak var btSearch: UIButton!

	@IBOutlet weak var btResignKeyboard: UIButton!

	@IBOutlet weak var nameLabel: UILabel!

	@IBOutlet weak var searchField: UITextField!

	private var searchBarIsShown = false

	private var shouldSyntaxHighlight = true

	private var selectedSearchResultIndex: Int?

	var document: TextDocument?

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
        
        CodeHighlighter.loadLibraries()

		// Cursor support
		if #available(iOS 13.4, *) {
			self.btDismiss.isPointerInteractionEnabled = true
			self.btSearch.isPointerInteractionEnabled = true
			self.btResignKeyboard.isPointerInteractionEnabled = true
		}

		// Access the document
		document?.open(completionHandler: { (success) in
			if success {
				// Display the content of the document, e.g.:
				self.nameLabel.text = self.document?.fileURL.lastPathComponent

				let text = self.document?.userText
				self.documentTextView.attributedText = NSAttributedString(
					string: text ?? "")

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

		self.resetTextViewContentInset()

		self.shouldSyntaxHighlight = Settings.enableSyntaxHighlight

		self.documentTextView.scrollRangeToVisible(
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

	@objc func keyboardWillShow(_ notification: Notification) {
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

	@objc func keyboardWillHide(_ notification: Notification) {
		self.resetTextViewContentInset()
	}

	@objc func showSearchField() {
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
			withDuration: 0.2, delay: 0,
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
		self.saveFile()
	}

	func textViewDidChange(_ textView: UITextView) {
		self.resetTextAttribute()
		self.textSearch()
	}

	// MARK: Private methods

	private func resetTextViewContentInset() {
		let safeAreaTopMargin =
			UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0
		let top = self.fakeNavBarView.frame.height - safeAreaTopMargin
		UIView.animate(withDuration: 0.1) {
			self.documentTextView.contentInset = UIEdgeInsets(
				top: top, left: 0, bottom: 0, right: 0)
		}
		self.documentTextView.scrollIndicatorInsets =
			self.documentTextView.contentInset
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

	private func setupSettings() {
        
        let font = Settings.fontStyle.uiFont

		self.documentTextView.font = font
		self.resetTextAttribute()
	}

	private func resetTextAttribute() {
		// Get cursor position
		let selectedTextRange = documentTextView.selectedTextRange
		let selectedRange = documentTextView.selectedRange

		guard let string = self.documentTextView.text else { return }
		let textColor = UIColor(named: "Text Color")
        let font = Settings.fontStyle.uiFont
		var attributedText = NSAttributedString(
			string: string,
			attributes: [
				NSAttributedString.Key.foregroundColor: textColor!,
                NSAttributedString.Key.font: font,
			])
		let fileExtension = self.document!.fileURL.pathExtension
		if self.shouldSyntaxHighlight {
			attributedText = CodeHighlighter.highlight(
				attributedText, fileExtension: fileExtension)
		}
		self.documentTextView.attributedText = attributedText
		self.documentTextView.selectedTextRange = selectedTextRange
		self.documentTextView.scrollRangeToVisible(selectedRange)

		self.documentTextView.scrollIndicatorInsets =
			self.documentTextView.contentInset
	}

	private func textSearch() {
		self.resetTextAttribute()
		let attributedText = NSMutableAttributedString(
			attributedString: self.documentTextView.attributedText)
		Utils.attributeMatchingResults(
			attributedText,
			pattern: self.searchField.text ?? "",
			caseSensitive: Settings.caseSensitiveTextSearching,
			attributes: [
				NSAttributedString.Key.backgroundColor: UIColor.yellow,
				NSAttributedString.Key.foregroundColor: UIColor.darkText,
			])

		self.documentTextView.attributedText = attributedText
	}

	private func selectNextTextSearchResult() {

		guard self.searchBarIsShown else { return }

		self.resetTextAttribute()
		self.textSearch()
		let ranges = Utils.findNSRangeOfPattern(
			string: self.documentTextView.attributedText.string,
			pattern: self.searchField.text ?? "",
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
