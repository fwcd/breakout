//
//  Moving.swift
//  Breakout
//
//  Created by Fredrik on 06.04.18.
//  Copyright © 2018 fwcd. All rights reserved.
//

import Foundation
import CoreGraphics

/**
 * A moving object with a velocity.
 */
protocol Moving: Positioned {
	var velocity: CGVector { get }
	
	func predictPos() -> CGPoint
}

extension Moving {
	func predictPos() -> CGPoint {
		return pos.add(velocity)
	}
}
