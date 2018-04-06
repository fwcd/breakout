//
//  Ball.swift
//  Breakout
//
//  Created by Fredrik on 03.04.18.
//  Copyright © 2018 fwcd. All rights reserved.
//

import Foundation
import CoreGraphics

/**
 * The central object that can destroy bricks.
 */
class Ball: Collidable, Rendereable {
	private(set) var radius: CGFloat
	private(set) var pos: CGPoint
	private var collided: Bool = false
	let color: CGColor
	var velocity: CGVector
	
	init(x: CGFloat, y: CGFloat, radius: CGFloat, initialVelocity: CGFloat, color: CGColor) {
		pos = CGPoint(x: x, y: y)
		self.radius = radius
		self.color = color
		
		// Choose a random angle between 200 and 340 degrees
		let angle: CGFloat = CGFloat(Double(arc4random_uniform(200) + 340) / Double(360)) * 2 * CGFloat.pi
		velocity = CGVector(dx: cos(angle) * initialVelocity, dy: sin(angle) * initialVelocity)
	}
	
	func update(game: BreakoutGame) {
		collided = false
		
		if hitsXWall(game.bounds) {
			HorizontalWallCollision().perform(ball: self, collidable: nil)
			collided = true
		} else if hitsYWall(game.bounds) {
			VerticalWallCollision().perform(ball: self, collidable: nil)
			collided = true
		}
		
		if game.nextLevel != nil {
			performCollisions(with: game.nextLevel!.bricks,
			                  remover: {(i) -> () in game.nextLevel!.destroyBrick(at: i)})
		}
		performCollisions(with: [game.paddle], remover: nil)
		performCollisions(with: game.currentLevel.bricks,
		                  remover: {(i) -> () in game.currentLevel.destroyBrick(at: i)})
		performCollisions(with: game.balls, remover: nil)
		
		move()
	}
	
	func grow() {
		radius *= 2
	}
	
	func shrink() {
		radius /= 2
	}
	
	private func performCollisions(with collidables: [Collidable], remover: ((Int) -> ())!) {
		if !collided {
			var i: Int = 0
			for collidable in collidables {
				let collision = collidable.collisionWith(ball: self)
				if collision != nil {
					collision!.perform(ball: self, collidable: collidable)
					if collidable.destroyUponHit() {
						remover(i)
					}
					collided = true
					break
				}
				i += 1
			}
		}
	}
	
	func rectCollisionWith(_ rect: CGRect) -> Collision? {
		let newPos = predictPos()
		
		if !hitsX(pos.x, rect) && hitsX(newPos.x, rect) && hitsY(pos.y, rect) && hitsY(newPos.y, rect) {
			return HorizontalWallCollision()
		} else if !hitsY(pos.y, rect) && hitsY(newPos.y, rect) && hitsX(pos.x, rect) && hitsX(newPos.x, rect) {
			return VerticalWallCollision()
		} else {
			return nil
		}
	}
	
	private func hitsXWall(_ bounds: CGRect) -> Bool {
		let x = pos.x + velocity.dx
		return (x - radius) < 0 || x >= bounds.width
	}
	
	private func hitsYWall(_ bounds: CGRect) -> Bool {
		let y = pos.y + velocity.dy
		return (y - radius) < 0 || y >= bounds.height
	}
	
	private func hitsX(_ x: CGFloat, _ rect: CGRect) -> Bool {
		return abs(x - clamp(x, min: rect.minX, max: rect.maxX)) <= radius
	}
	
	private func hitsY(_ y: CGFloat, _ rect: CGRect) -> Bool {
		return abs(y - clamp(y, min: rect.minY, max: rect.maxY)) <= radius
	}
	
	private func predictPos() -> CGPoint {
		return pos.add(velocity)
	}
	
	private func move() {
		pos = predictPos()
	}
	
	func render(to context: CGContext) {
		context.setFillColor(color)
		context.fillEllipse(in: CGRect(x: pos.x - radius, y: pos.y - radius, width: (radius * 2), height: (radius * 2)))
	}
	
	func collisionWith(ball: Ball) -> Collision? {
		if ball !== self {
			if pos.distTo(point: ball.pos) < (radius + ball.radius) {
				return VelocitySwapCollision()
			}
		}
		
		return nil
	}
	
	func destroyUponHit() -> Bool {
		return false
	}
}
