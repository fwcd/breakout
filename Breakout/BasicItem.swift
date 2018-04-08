//
//  BasicItem.swift
//  Breakout
//
//  Created by Fredrik on 06.04.18.
//  Copyright © 2018 fwcd. All rights reserved.
//

import Foundation
import UIKit

class BasicItem: Item {
	private(set) var pos: CGPoint = CGPoint(x: 0, y: 0)
	private(set) var radius: CGFloat = 80
	private let background: UIImage = #imageLiteral(resourceName: "ItemBackground")
	private var textureSize: CGSize!
	private var acceleration: CGVector = CGVector(dx: 0, dy: 0.2)
	var game: BreakoutGame!
	var velocity: CGVector = CGVector(dx: 0, dy: 0)
	var texture: UIImage?
	
	func place(at pos: CGPoint, withSpeed speed: CGFloat, andRadius radius: CGFloat) {
		self.pos = pos
		self.radius = radius
		textureSize = CGSize(width: radius, height: radius)
		velocity = CGVector(dx: 0, dy: speed)
		texture = loadTexture()
	}
	
	func loadTexture() -> UIImage? {
		return nil
	}
	
	func setGame(_ game: BreakoutGame) {
		self.game = game
	}
	
	func fall() {
		velocity.addMutate(acceleration)
		pos.addMutate(velocity)
	}
	
	func collidesWith(paddle: Paddle) -> Bool {
		return collisionOf(rect: paddle, withMovingCircle: self) != nil
	}
	
	func onPickUp() {
		// By default nothing happens
	}
	
	func render(to context: CGContext) {
		let rect = CGRect(origin: pos, size: textureSize)
		background.draw(in: rect)
		texture?.draw(in: rect)
	}
	
	func collisionWith(ball: Ball) -> BallCollision? {
		return collisionOf(movingCircle: self, withMovingCircle: ball)
	}
	
	func destroyUponHit() -> Bool {
		return true
	}
	
	static func ==(lhs: BasicItem, rhs: BasicItem) -> Bool {
		return lhs === rhs
	}
}
