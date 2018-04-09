//
//  HardBrick.swift
//  Breakout
//
//  Created by Fredrik on 04.04.18.
//  Copyright © 2018 fwcd. All rights reserved.
//

import Foundation
import UIKit

/**
 * A brick that breaks after a fixed number
 * of hits.
 */
class HardBrick: BasicBrick {
	let resistance: Int // The initial amount of hits the brick can take before breaking
	private(set) var hitsLeft: Int // The current amount of hits the brick can take
	private var color: CGColor = UIColor.magenta.cgColor
	
	init(resistance: Int) {
		self.resistance = resistance
		hitsLeft = resistance
	}
	
	override func getColor() -> CGColor {
		return color
	}
	
	override func onHit(ball: Ball) {
		hitsLeft -= 1
		if color.alpha > 0.4 {
			color = color.copy(alpha: color.alpha / 2)!
		}
	}
	
	override func destroyUponHit() -> Bool {
		return hitsLeft <= 0
	}
	
	override func render(to context: CGContext) {
		super.render(to: context)
		if hitsLeft < resistance {
			let label = "\(hitsLeft)" as NSString
			let attributes = [
					NSAttributedStringKey.font : UIFont.systemFont(ofSize: bounds.height * 0.75),
					NSAttributedStringKey.foregroundColor : UIColor.white
			]
			label.draw(at: pos, withAttributes: attributes)
		}
	}
}
