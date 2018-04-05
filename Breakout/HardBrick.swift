//
//  HardBrick.swift
//  Breakout
//
//  Created by Fredrik on 04.04.18.
//  Copyright © 2018 fwcd. All rights reserved.
//

import Foundation
import UIKit

class HardBrick: Brick {
	var hitsLeft: Int // The amount of hits the brick can take before breaking
	private var color: CGColor = UIColor.magenta.cgColor
	
	init(resistance: Int) {
		hitsLeft = resistance
	}
	
	override func getColor() -> CGColor {
		return color
	}
	
	override func destroyUponHit() -> Bool {
		if (hitsLeft <= 0) {
			return true
		} else {
			hitsLeft -= 1
			color = color.copy(alpha: color.alpha / 2)!
			return false
		}
	}
}
