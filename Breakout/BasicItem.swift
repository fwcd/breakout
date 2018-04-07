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
	private var game: BreakoutGame!
	var velocity: CGVector = CGVector(dx: 0, dy: 0)
	var texture: UIImage?
	
	func place(at pos: CGPoint, withSpeed speed: CGFloat, andRadius radius: CGFloat) {
		self.pos = pos
		self.radius = radius
		textureSize = CGSize(width: radius, height: radius)
		velocity = CGVector(dx: 0, dy: speed)
	}
	
	func setGame(_ game: BreakoutGame) {
		self.game = game
	}
	
	func fall() {
		velocity.addMutate(acceleration)
		pos.addMutate(velocity)
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
		if ball !== self {
			let dist = sqrt(pow(ball.pos.x - pos.x, 2) + pow(ball.pos.y - pos.y, 2))
			if dist < radius {
				return VelocitySwapCollision()
			}
		}
		
		return nil
	}
	
	func onHit(ball: Ball) {
		
	}
	
	func destroyUponHit() -> Bool {
		return true
	}
}
