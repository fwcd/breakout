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
 * The central game object that can destroy bricks.
 */
class Ball: Circular, BallCollidable, Rendereable, Equatable {
	private(set) var radius: CGFloat
	private(set) var pos: CGPoint
	private var collided: Bool = false
	private var effects = [BallEffect : DateSpan]()
	var score = Holder<Int>(with: 0)
	let color: CGColor
	var velocity: CGVector
	
	init(x: CGFloat, y: CGFloat, radius: CGFloat, initialVelocity: CGFloat, color: CGColor) {
		pos = CGPoint(x: x, y: y)
		self.radius = radius
		self.color = color
		
		let angle: CGFloat = randomAngleRad(betweenDeg: 200, andDeg: 340)
		velocity = CGVector(angleRad: angle, length: initialVelocity)
	}
	
	func add(effect: BallEffect, forSeconds sec: Double) {
		effects[effect] = DateSpan(start: Date(), duration: sec)
		effect.apply(to: self)
	}
	
	private func renderEffects(to context: CGContext) {
		let strokeWidth: CGFloat = radius / 3
		context.setLineWidth(strokeWidth)
		var arcRadius: CGFloat = radius + strokeWidth
		
		for (effect, timeSpan) in effects {
			let progress: CGFloat = CGFloat(timeSpan.getProgress())
			let angle: CGFloat = progress * 2 * CGFloat.pi
			
			context.setStrokeColor(effect.color.cgColor)
			context.addArc(center: pos, radius: arcRadius, startAngle: 0, endAngle: angle, clockwise: true)
			context.strokePath()
			
			arcRadius += strokeWidth * 2
		}
	}
	
	func render(to context: CGContext) {
		renderEffects(to: context)
		context.setFillColor(color)
		context.fillEllipse(in: CGRect(x: pos.x - radius, y: pos.y - radius, width: (radius * 2), height: (radius * 2)))
	}
	
	private func updateEffects() {
		for (effect, timeSpan) in effects {
			if timeSpan.hasPassed() {
				effect.remove(from: self)
				effects.removeValue(forKey: effect)
			}
		}
	}
	
	func update(game: BreakoutGame) {
		updateEffects()
		
		collided = false
		let newPos = predictPos()
		let isInBounds = game.bounds.contains(self, withPadding: -radius)
		let hitsGround = hitsBottomWall(newPos.y, game.bounds)
		let staysInGame = (!hitsGround || game.testModeEnabled.value) && isInBounds
		
		if staysInGame {
			if hitsSideWall(newPos.x, game.bounds) {
				InvertXCollision().perform(ball: self, collidable: nil)
			} else if (hitsGround && game.testModeEnabled.value) || hitsTopWall(newPos.y, game.bounds) {
				InvertYCollision().perform(ball: self, collidable: nil)
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
		} else {
			game.remove(ball: self)
		}
	}
	
	func grow(byFactor factor: CGFloat) {
		radius *= factor
	}
	
	func shrink(byFactor factor: CGFloat) {
		radius /= factor
	}
	
	private func performCollisions(with collidables: [BallCollidable], remover: ((Int) -> ())!) {
		if !collided {
			for (i, collidable) in collidables.enumerated().reversed() {
				let collision = collidable.collisionWith(ball: self)
				if collision != nil {
					collision!.perform(ball: self, collidable: collidable)
					collidable.onHit(ball: self)
					if collidable.destroyUponHit() {
						score.value += 1
						remover(i)
					}
					collided = true
					break
				}
			}
		}
	}
	
	private func hitsSideWall(_ x: CGFloat, _ bounds: CGRect) -> Bool {
		return (x - radius) <= 0 || (x + radius) >= bounds.width
	}
	
	private func hitsTopWall(_ y: CGFloat, _ bounds: CGRect) -> Bool {
		return (y - radius) <= 0
	}
	
	private func hitsBottomWall(_ y: CGFloat, _ bounds: CGRect) -> Bool {
		return (y + radius) >= bounds.height
	}
	
	private func move() {
		pos.addMutate(velocity)
	}
	
	func collisionWith(ball: Ball) -> BallCollision? {
		if ball !== self {
			return collisionOf(movingCircle: self, withMovingCircle: ball)
		}
		
		return nil
	}
	
	func destroyUponHit() -> Bool {
		return false
	}
	
	static func ==(lhs: Ball, rhs: Ball) -> Bool {
		return lhs === rhs
	}
}
