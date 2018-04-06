//
//  Collidable.swift
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
protocol Collidable: Moving {
	var velocity: CGVector { get set }
	
	func collisionWith(ball: Ball) -> Collision?
	
	func destroyUponHit() -> Bool
}
