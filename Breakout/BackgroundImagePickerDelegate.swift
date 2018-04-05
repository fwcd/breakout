//
//  BackgroundImagePickerDelegate.swift
//  Breakout
//
//  Created by Fredrik on 05.04.18.
//  Copyright © 2018 fwcd. All rights reserved.
//

import Foundation
import UIKit

class BackgroundImagePickerDelegate: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	private let onSelectImage: (UIImage) -> ()
	
	init(onSelectImage: @escaping (UIImage) -> ()) {
		self.onSelectImage = onSelectImage
	}
	
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
		onSelectImage(info[UIImagePickerControllerOriginalImage] as! UIImage)
	}
}
