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
 * The main game class that contains the paddle,
 * balls and levels.
 */
class BreakoutGame: Rendereable {
	// TODO: Rearchitect this class to properly support MVC
	
	private let controller: BreakoutGameController
	private let view: BreakoutGameView
	var bounds: CGRect {
		get { return view.bounds }
	}
	
	private let paddleColor: CGColor = UIColor.orange.cgColor
	private let brickColor: CGColor = UIColor.yellow.cgColor
	private let ballColor: CGColor = UIColor.white.cgColor
	private let xBricks: Int = 8
	private var initialBallSpeed: CGFloat!
	
	var backgroundImage: UIImage?
	private(set) var currentLevel: Level = Level1()
	private(set) var nextLevel: Level? = Level2()
	private var transition: Transition?
	
	private(set) var hud: HUD!
	private(set) var paddle: Paddle!
	var balls = [Ball]()
	var items = [Item]()
	
	private(set) var score = Holder<Int>(with: 0)
	private(set) var levelIndex = Holder<Int>(with: 1)
	
	init(controller: BreakoutGameController, initialBallSpeed: CGFloat, initialBallCount: Int) {
		self.controller = controller
		view = controller.view as! BreakoutGameView
		view.setGame(self)
		self.initialBallSpeed = initialBallSpeed
		hud = HUD(
				x: 10,
				y: 10,
				color: UIColor.white,
				fontSize: bounds.height * 0.03)
		hud.score = score
		hud.levelIndex = levelIndex
		
		paddle = Paddle(
				centerX: bounds.width / 2,
				centerY: bounds.height * 0.8,
				width: bounds.width * 0.2,
				height: bounds.height * 0.02,
				color: paddleColor)
		
		for _ in 0..<initialBallCount {
			spawnBall()
		}
		
		prepare(level: currentLevel, offset: CGVector(dx: 0, dy: 0))
	}
	
	func spawnBall() {
		let ball = Ball(
			x: bounds.width / 2,
			y: bounds.height / 2,
			radius: bounds.height * 0.01,
			initialVelocity: initialBallSpeed,
			color: ballColor)
		ball.score = score
		balls.append(ball)
	}
	
	private func advanceToNextLevel() {
		if transition == nil && nextLevel != nil {
			prepare(level: nextLevel!, offset: CGVector(dx: 0, dy: -bounds.height))
			transition = Transition(
				start: CGPoint(x: 0, y: -bounds.height),
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
			let pickUp: Bool = item.collidesWith(paddle: paddle)
			
			if pickUp {
				item.onPickUp()
			} else {
				item.fall()
			}
			
			if pickUp || item.pos.y > bounds.height {
				items.remove(at: i)
			}
			i += 1
		}
		
		if currentLevel.isCompleted() {
			advanceToNextLevel()
		}
	}
	
	func gameOver() {
		let alert = UIAlertController(title: "Game Over", message: hud.getLine(), preferredStyle: .alert)
		controller.present(alert, animated: true, completion: nil)
	}
	
	private func prepare(level: Level, offset: CGVector) {
		let brickPadding: CGFloat = bounds.height * 0.003
		let brickWidth: CGFloat = bounds.width / CGFloat(xBricks)
		let brickHeight: CGFloat = bounds.height * 0.03
		let startY: CGFloat = bounds.height * 0.1
		
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
	
	func render(to context: CGContext) {
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
