//
//  BreakoutView.swift
//  Breakout
//
//  Created by Fredrik on 03.04.18.
//  Copyright © 2018 fwcd. All rights reserved.
//

import Foundation
import UIKit

/**
 * The game view that contains the paddle,
 * balls and levels.
 */
class BreakoutGame: UIView {
	private let paddleColor: CGColor = UIColor.orange.cgColor
	private let brickColor: CGColor = UIColor.yellow.cgColor
	private let ballColor: CGColor = UIColor.white.cgColor
	private let xBricks: Int = 8
	
	var backgroundImage: UIImage?
	private(set) var currentLevel: Level = Level1()
	private(set) var nextLevel: Level? = Level2()
	private var transition: Transition?
	
	private(set) var hud: HUD!
	private(set) var paddle: Paddle!
	private(set) var balls = [Ball]()
	var items = [Item]()
	
	private(set) var score = Holder<Int>(with: 0)
	private(set) var levelIndex = Holder<Int>(with: 1)
	
	func prepare(initialBallSpeed: CGFloat, initialBallCount: Int) {
		hud = HUD(
				x: 10,
				y: 10,
				color: UIColor.white,
				fontSize: frame.height * 0.03)
		hud.score = score
		hud.levelIndex = levelIndex
		
		paddle = Paddle(
				centerX: frame.width / 2,
				centerY: frame.height * 0.8,
				width: frame.width * 0.2,
				height: frame.height * 0.02,
				color: paddleColor)
		
		for _ in 0..<initialBallCount {
			let ball = Ball(
				x: frame.width / 2,
				y: frame.height / 2,
				radius: frame.height * 0.01,
				initialVelocity: initialBallSpeed,
				color: ballColor)
			ball.score = score
			balls.append(ball)
		}
		
		prepare(level: currentLevel, offset: CGVector(dx: 0, dy: 0))
	}
	
	private func advanceToNextLevel() {
		if transition == nil && nextLevel != nil {
			prepare(level: nextLevel!, offset: CGVector(dx: 0, dy: -frame.height))
			transition = Transition(
				start: CGPoint(x: 0, y: -frame.height),
				goal: CGPoint(x: 0, y: 0),
				speed: 3,
				moveables: [currentLevel, nextLevel!],
				style: .accelerateAndDecelerate)
			levelIndex.value += 1
		}
	}
	
	func update() {
		transition?.advance()
		if !(transition?.inProgress() ?? true) {
			currentLevel = nextLevel!
			nextLevel = currentLevel.nextLevel
			transition = nil
		}
		
		var i = 0
		for item in items {
			item.fall()
			
			if item.pos.y > bounds.height {
				items.remove(at: i)
			}
			i += 1
		}
		
		if currentLevel.isCompleted() {
			advanceToNextLevel()
		}
	}
	
	private func prepare(level: Level, offset: CGVector) {
		let brickPadding: CGFloat = frame.height * 0.003
		let brickWidth: CGFloat = frame.width / CGFloat(xBricks)
		let brickHeight: CGFloat = frame.height * 0.03
		let startY: CGFloat = frame.height * 0.1
		
		for gridY in 0..<level.yBricks {
			for gridX in 0..<xBricks {
				let x: CGFloat = (CGFloat(gridX) * brickWidth) + brickPadding + offset.dx
				let y: CGFloat = startY + (CGFloat(gridY) * brickHeight) + brickPadding + offset.dy
				let w: CGFloat = brickWidth - (brickPadding * 2)
				let h: CGFloat = brickHeight - (brickPadding * 2)
				
				level.addBrick(in: CGRect(x: x, y: y, width: w, height: h), with: self)
			}
		}
	}
	
	override func draw(_ rect: CGRect) {
		guard let context: CGContext = UIGraphicsGetCurrentContext() else { return }
		
		backgroundImage?.draw(in: bounds)
		paddle.render(to: context)
		for ball in balls {
			ball.render(to: context)
		}
		currentLevel.render(to: context)
		nextLevel?.render(to: context)
		for item in items {
			item.render(to: context)
		}
		hud?.render(to: context)
	}
}
