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
class BreakoutGame: Rendereable, Ticking {
	private let controller: BreakoutGameController
	private let view: BreakoutGameView
	var bounds: CGRect {
		get { return view.bounds }
	}
	
	private let paddleColor: CGColor = UIColor.orange.cgColor
	private let brickColor: CGColor = UIColor.yellow.cgColor
	private let ballColor: CGColor = UIColor.white.cgColor
	
	private let xBricks: Int = 8
	private let initialBallSpeed: CGFloat
	private let initialBallCount: Int
	
	private var initialLevel: Level {
		get { return Level1() }
	}
	private(set) var currentLevel: Level!
	private(set) var nextLevel: Level?
	private var transition: Transition?
	private var progressives = [Progressive]()
	
	private(set) var hud: HUD!
	private(set) var paddle: Paddle!
	var balls = [Ball]()
	var items = [Item]()
	
	/**
	 * Aggregates all current bricks.
	 * Runs in O(n) time each call. Mutating
	 * the resulting array has no effect
	 * on the actual bricks.
	 */
	var bricks: [Brick] {
		get {
			var buffer = [Brick]()
			buffer.append(contentsOf: currentLevel.bricks)
			if nextLevel != nil {
				buffer.append(contentsOf: nextLevel!.bricks)
			}
			return buffer
		}
	}
	
	private(set) var score = Holder<Int>(with: 0)
	private(set) var levelIndex = Holder<Int>(with: 1)
	
	var backgroundImage = Holder<UIImage?>(with: nil)
	var testModeEnabled = Holder<Bool>(with: false)
	
	init(controller: BreakoutGameController, initialBallSpeed: CGFloat, initialBallCount: Int) {
		self.controller = controller
		self.initialBallSpeed = initialBallSpeed
		self.initialBallCount = initialBallCount
		
		view = controller.view as! BreakoutGameView
		view.setGame(self)
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
		
		restart()
	}
	
	func restart() {
		score.value = 0
		levelIndex.value = 1
		
		balls.removeAll()
		items.removeAll()
		let ballCount = testModeEnabled.value ? 20 : initialBallCount
		for _ in 0..<ballCount {
			spawnBall()
		}
		
		currentLevel = initialLevel
		nextLevel = currentLevel.nextLevel
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
	
	func spawnExplosion(at pos: GridPosition, withRadius radius: CGFloat) {
		progressives.append(BrickExplosion(at: pos, withRadius: radius, inGame: self))
	}
	
	func addToAllBalls(effect: BallEffect, forSeconds: Double) {
		for ball in balls {
			ball.add(effect: effect, forSeconds: forSeconds)
		}
	}
	
	private func advanceToNextLevel() {
		// A transition is intentionally not added to the
		// list of progressives as there only should be one
		// transition at a time.
		
		if transition == nil && nextLevel != nil {
			prepare(level: nextLevel!, offset: CGVector(dx: 0, dy: -bounds.height))
			transition = Transition(
				start: CGPoint(x: 0, y: -bounds.height),
				goal: CGPoint(x: 0, y: 0),
				speed: 3,
				moveables: [currentLevel, nextLevel!],
				style: .accelerateAndDecelerate)
			levelIndex.value += 1
		} else {
			print("Warning: Can't advance to next level without a level or while a transition is running!")
		}
	}
	
	func tick() {
		transition?.advance()
		if transition?.isFinished() ?? false {
			currentLevel = nextLevel!
			nextLevel = currentLevel.nextLevel
			transition = nil
		}
		
		for (i, progressive) in progressives.enumerated().reversed() {
			progressive.advance()
			if progressive.isFinished() {
				progressives.remove(at: i)
			}
		}
		
		for (i, item) in items.enumerated().reversed() {
			let pickUp: Bool = item.collidesWith(paddle: paddle)
			
			if pickUp {
				item.onPickUp()
			} else {
				item.fall()
			}
			
			if pickUp || item.pos.y > bounds.height {
				items.remove(at: i)
			}
		}
		
		if currentLevel.isCompleted() {
			advanceToNextLevel()
		}
		
		for ball in balls {
			ball.update(game: self)
		}
	}
	
	func remove(ball: Ball) {
		removeFromArray(ball, from: &balls)
		if !testModeEnabled.value && isGameOver() {
			// TODO: Don't show alert/game over message if the view is covered
			showGameOver()
		}
	}
	
	func isGameOver() -> Bool {
		return balls.count == 0
	}
	
	func showGameOver() {
		let alert = UIAlertController(title: "Game Over", message: hud.getLine(), preferredStyle: .alert)
		let action = UIAlertAction(title: "Restart", style: .default, handler: {(a) -> () in self.restart()})
		alert.addAction(action)
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
				
				level.addBrick(in: CGRect(x: x, y: y, width: w, height: h), with: self, at: GridPosition(x: gridX, y: gridY))
			}
		}
	}
	
	func render(to context: CGContext) {
		backgroundImage.value?.draw(in: bounds)
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
