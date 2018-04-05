//
//  SettingsViewController.swift
//  Breakout
//
//  Created by Fredrik on 04.04.18.
//  Copyright © 2018 fwcd. All rights reserved.
//

import Foundation
import UIKit
import MobileCoreServices

class SettingsViewController : UITableViewController {
	private var bgPickerDelegate: BackgroundImagePickerDelegate!
	private var imgPickerController: UIImagePickerController!
	@IBOutlet var imgView: UIImageView!
	public private(set) var selectedImage: UIImage?
	
	func updateImagePreview(with image: UIImage?) {
		imgView.image = image
		imgView.setNeedsDisplay()
	}
	
	override func viewDidLoad() {
		bgPickerDelegate = BackgroundImagePickerDelegate(onSelectImage: {(img) -> () in self.onSelectImage(image: img)})
		let sourceType = UIImagePickerControllerSourceType.photoLibrary
		let mediaType = String(kUTTypeImage)
		
		if UIImagePickerController.isSourceTypeAvailable(sourceType) && (UIImagePickerController.availableMediaTypes(for: sourceType)?.contains(mediaType) ?? false) {
			imgPickerController = UIImagePickerController()
			imgPickerController.mediaTypes = [mediaType]
			imgPickerController.delegate = bgPickerDelegate
		}
	}
	
	private func onSelectImage(image: UIImage) {
		updateImagePreview(with: image)
		selectedImage = image
		imgPickerController.dismiss(animated: true, completion: nil)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.destination is BreakoutGameController {
			(segue.destination as! BreakoutGameController).bView.backgroundImage = imgView.image
		}
	}
	
	@IBAction func openImagePicker(_ sender: Any) {
		present(imgPickerController, animated: true, completion: nil)
	}
}
