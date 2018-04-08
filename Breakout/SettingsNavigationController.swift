//
//  SettingsNavigationController.swift
//  Breakout
//
//  Created by Fredrik on 08.04.18.
//  Copyright © 2018 fwcd. All rights reserved.
//

import Foundation
import UIKit

class SettingsNavigationController: UINavigationController {
	var settings: SettingsViewController? {
		get {
			if childViewControllers.count == 1 {
				return childViewControllers[0] as? SettingsViewController
			} else {
				return nil
			}
		}
	}
}
