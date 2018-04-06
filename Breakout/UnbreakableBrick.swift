//
//  UnbreakableBrick.swift
//  Breakout
//
//  Created by Fredrik on 04.04.18.
//  Copyright © 2018 fwcd. All rights reserved.
//

import Foundation
import UIKit

/**
 * A brick that cannot be broken.
 */
class UnbreakableBrick: BasicBrick {
	override func getColor() -> CGColor {
		return UIColor.red.cgColor
	}
	
	override func destroyUponHit() -> Bool {
		return false
	}
	
	override func affectsLevelCounter() -> Bool {
		return false
	}
}
