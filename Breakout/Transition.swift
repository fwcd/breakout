//
//  Transition.swift
//  Breakout
//
//  Created by Fredrik on 04.04.18.
//  Copyright © 2018 fwcd. All rights reserved.
//

import Foundation
import CoreGraphics

enum TransitionStyle {
	case linear
	case accelerate
	case decelerate
	case accelerateAndDecelerate
}

/**
 * A smooth, linear transition between
 * two position states of a variable number
 * of moveable objects.
 */
class Transition: Progressive {
	private(set) var current: CGPoint
	private(set) var speed: CGFloat
	private let acceleration: CGFloat = 1
	private var firstHalf: Bool = true
	let start: CGPoint
	let goal: CGPoint
	let moveables: [Moveable]
	let style: TransitionStyle
	
	init(start: CGPoint, goal: CGPoint, speed: CGFloat, moveables: [Moveable], style: TransitionStyle) {
		current = start
		self.start = start
		self.goal = goal
		self.speed = speed
		self.moveables = moveables
		self.style = style
	}
	
	func advance() {
		if style == .accelerate || (firstHalf && style == .accelerateAndDecelerate) {
			speed += acceleration
		} else if style == .decelerate || (!firstHalf && style == .accelerateAndDecelerate) {
			if speed > acceleration {
				speed -= acceleration
			}
		}
		
		let d = getDeltaVec()
		
		for moveable in moveables {
			moveable.move(by: d)
		}
		
		current.addMutate(d)
		
		if firstHalf && hasProgressedMoreThanHalfway() {
			firstHalf = false
		}
	}
	
	private func getDeltaVec() -> CGVector {
		return CGVector(dx: delta(goal.x - current.x), dy: delta(goal.y - current.y))
	}
	
	private func delta(_ n: CGFloat) -> CGFloat {
		let step = min(n, speed)
		return (n > 0) ? step : (n < 0 ? -step : 0)
	}
	
	func hasProgressedMoreThanHalfway() -> Bool {
		return current.distTo(point: goal) < current.distTo(point: start)
	}
	
	func isFinished() -> Bool {
		return current == goal
	}
}
