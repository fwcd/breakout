//
//  Collision.swift
//  Breakout
//
//  Created by Fredrik on 03.04.18.
//  Copyright © 2018 fwcd. All rights reserved.
//

import Foundation
import CoreGraphics

/**
 * A collision between a ball and
 * another collidable object.
 */
protocol Collision {
	func perform(ball: Ball, collidable: Collidable!)
}

class HorizontalWallCollision : Collision {
	func perform(ball: Ball, collidable: Collidable!) {
		ball.velocity = CGVector(dx: -ball.velocity.dx, dy: ball.velocity.dy)
	}
}

class VerticalWallCollision : Collision {
	func perform(ball: Ball, collidable: Collidable!) {
		ball.velocity = CGVector(dx: ball.velocity.dx, dy: -ball.velocity.dy)
	}
}

class BallCollision : Collision {
	func perform(ball: Ball, collidable: Collidable!) {
		var mutableCollidable: Collidable! = collidable
		let ballVelocity: CGVector = ball.velocity
		
		// Swap velocities
		ball.velocity = collidable.velocity
		mutableCollidable.velocity = ballVelocity
	}
}
