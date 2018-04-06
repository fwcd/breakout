//
//  BasicBrick.swift
//  Breakout
//
//  Created by Fredrik on 06.04.18.
//  Copyright © 2018 fwcd. All rights reserved.
//

import Foundation
import UIKit
import CoreGraphics

/**
 * A basic brick that is immediately destroyed
 * upon being hit.
 */
class BasicBrick: Brick {
	var velocity: CGVector = CGVector(dx: 0, dy: 0)
	var bounds: CGRect!
	var pos: CGPoint {
		get { return bounds.origin }
	}
	
	func placeIn(bounds: CGRect) {
		self.bounds = bounds
	}
	
	func placeAt(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) {
		bounds = CGRect(x: x, y: y, width: width, height: height)
	}
	
	func move(by vec: CGVector) {
		bounds = bounds.offsetBy(dx: vec.dx, dy: vec.dy)
	}
	
	func getColor() -> CGColor {
		return UIColor.yellow.cgColor
	}
	
	func render(to context: CGContext) {
		context.setFillColor(getColor())
		context.fill(bounds)
	}
	
	func collisionWith(ball: Ball) -> Collision? {
		return ball.rectCollisionWith(bounds)
	}
	
	func destroyUponHit() -> Bool {
		return true
	}
	
	func affectsLevelCounter() -> Bool {
		return true
	}
}
