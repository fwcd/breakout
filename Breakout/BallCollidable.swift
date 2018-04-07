//
//  BallCollidable.swift
//  Breakout
//
//  Created by Fredrik on 03.04.18.
//  Copyright © 2018 fwcd. All rights reserved.
//

import Foundation
import CoreGraphics

/**
 * An object that can collide with a ball
 * and optionally be destroyed.
 */
protocol BallCollidable: Moving {
	var velocity: CGVector { get set }
	
	func collisionWith(ball: Ball) -> BallCollision?
	
	func destroyUponHit() -> Bool
	
	func onHit(ball: Ball)
}

extension BallCollidable {
	func onHit(ball: Ball) {
		// Do nothing by default
	}
}
