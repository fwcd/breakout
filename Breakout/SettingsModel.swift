//
//  SettingsModel.swift
//  Breakout
//
//  Created by Fredrik on 08.04.18.
//  Copyright © 2018 fwcd. All rights reserved.
//

import Foundation
import UIKit

class SettingsModel {
	var backgroundImage = Holder<UIImage?>(with: nil)
	var testModeEnabled = Holder<Bool>(with: false)
}
