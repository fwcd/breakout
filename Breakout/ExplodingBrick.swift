//
//  ExplodingBrick.swift
//  Breakout
//
//  Created by Fredrik on 11.04.18.
//  Copyright © 2018 fwcd. All rights reserved.
//

import Foundation
import UIKit
import CoreGraphics

class ExplodingBrick: BasicBrick {
	private let radius: CGFloat
	
	init(radius: CGFloat) {
		self.radius = radius
	}
	
	override func getColor() -> CGColor {
		return UIColor.orange.cgColor
	}
	
	override func onHit(ball: Ball) {
		game.spawnExplosion(at: gridPosition, withRadius: radius)
	}
	
	override func destroyUponHit() -> Bool {
		return true
	}
	
	override func affectsLevelCounter() -> Bool {
		return true
	}
}
