//
//  BasicItem.swift
//  Breakout
//
//  Created by Fredrik on 06.04.18.
//  Copyright © 2018 fwcd. All rights reserved.
//

import Foundation
import CoreGraphics

class BasicItem: Item {
	private(set) var pos: CGPoint
	private(set) var texture: CGImage
	private(set) var radius: CGFloat
	private let textureSize: CGSize
	var velocity: CGVector
	
	init(texture: CGImage, pos: CGPoint, speed: CGFloat) {
		self.texture = texture
		self.pos = pos
		textureSize = CGSize(width: texture.width, height: texture.height)
		radius = CGFloat(texture.width)
		velocity = randomCGVector(length: speed)
	}
	
	func onPickUp(game: BreakoutGame) {
		
	}
	
	func render(to context: CGContext) {
		context.draw(texture, in: CGRect(origin: pos, size: textureSize))
	}
	
	func collisionWith(ball: Ball) -> Collision? {
		if ball !== self {
			let dist = sqrt(pow(ball.pos.x - pos.x, 2) + pow(ball.pos.y - pos.y, 2))
			if dist < radius {
				return VelocitySwapCollision()
			}
		}
		
		return nil
	}
	
	func destroyUponHit() -> Bool {
		return true
	}
}
