//
//  GrowBallEffect.swift
//  Breakout
//
//  Created by Fredrik on 08.04.18.
//  Copyright © 2018 fwcd. All rights reserved.
//

import Foundation
import UIKit

class GrowBallEffect: BallEffect {
	let growFactor: CGFloat
	override var color: UIColor {
		get { return UIColor.orange }
	}
	
	init(growFactor: CGFloat) {
		self.growFactor = growFactor
	}
	
	override func apply(to ball: Ball) {
		ball.grow(byFactor: growFactor)
	}
	
	override func remove(from ball: Ball) {
		ball.shrink(byFactor: growFactor)
	}
}
