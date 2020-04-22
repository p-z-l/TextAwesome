//
//  DocumentBrowserViewController.swift
//  TextAwesome
//
//  Created by Peter Luo on 2020/3/29.
//  Copyright © 2020 Peter Luo. All rights reserved.
//

import UIKit

class DocumentBrowserViewController: UIDocumentBrowserViewController,
	UIDocumentBrowserViewControllerDelegate
{

	// MARK: ViewController lifecycle

	override func viewDidLoad() {
		super.viewDidLoad()

		delegate = self

		allowsDocumentCreation = true
		allowsPickingMultipleItems = false

		let btSettings = UIBarButtonItem(
			image: UIImage(systemName: "gear"), style: .plain, target: self,
			action: #selector(showSettings))
		self.additionalLeadingNavigationBarButtonItems.append(btSettings)

		CodeHighlighter.initializeLangDictionaries()
	}

	// MARK: Actions

	@objc private func showSettings() {
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let settingsVC = storyboard.instantiateViewController(
			identifier: "SettingsNav")

		self.present(settingsVC, animated: true)
	}

	// MARK: UIDocumentBrowserViewControllerDelegate

	func documentBrowser(
		_ controller: UIDocumentBrowserViewController,
		didRequestDocumentCreationWithHandler importHandler: @escaping (
			URL?, UIDocumentBrowserViewController.ImportMode
		) -> Void
	) {

		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		guard
			let fileTypeVC = storyboard.instantiateViewController(
				identifier: "FileTypesVC") as? FileTypeTableViewController
		else {
			importHandler(nil, .none)
			return
		}
		self.present(fileTypeVC, animated: true)
		fileTypeVC.didSelectFileType { (fileType) in
			let url: URL?

			url = try? FileManager.default.url(
				for: .applicationSupportDirectory, in: .userDomainMask,
				appropriateFor: nil, create: true
			)
			.appendingPathComponent(
				"\(fileType.defaultName).\(fileType.fileExtension)")

			guard url != nil else {
				importHandler(nil, .none)
				return
			}
			FileManager.default.createFile(atPath: url!.path, contents: Data())
			let document = TextDocument(fileURL: url!)
			document.save(to: url!, for: .forCreating, completionHandler: nil)

			importHandler(url, .copy)
		}
		fileTypeVC.willCancelSelection {
			importHandler(nil, .none)
		}

	}

	func documentBrowser(
		_ controller: UIDocumentBrowserViewController,
		didPickDocumentsAt documentURLs: [URL]
	) {
		guard let sourceURL = documentURLs.first else { return }

		// Present the Document View Controller for the first document that was picked.
		// If you support picking multiple items, make sure you handle them all.
		presentDocument(at: sourceURL)
	}

	func documentBrowser(
		_ controller: UIDocumentBrowserViewController,
		didImportDocumentAt sourceURL: URL, toDestinationURL destinationURL: URL
	) {
		// Present the Document View Controller for the new newly created document
		presentDocument(at: destinationURL)
	}

	func documentBrowser(
		_ controller: UIDocumentBrowserViewController,
		failedToImportDocumentAt documentURL: URL, error: Error?
	) {
		// Make sure to handle the failed import appropriately, e.g., by presenting an error message to the user.
	}

	// MARK: Document Presentation

	func presentDocument(at documentURL: URL) {

		let storyBoard = UIStoryboard(name: "Main", bundle: nil)
		let documentViewController =
			storyBoard.instantiateViewController(
				withIdentifier: "DocumentViewController")
			as! DocumentViewController
		documentViewController.document = TextDocument(fileURL: documentURL)
		documentViewController.modalPresentationStyle = .fullScreen

		present(documentViewController, animated: true, completion: nil)
	}
}
