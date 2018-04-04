//
//  Transition.swift
//  Breakout
//
//  Created by Fredrik on 04.04.18.
//  Copyright © 2018 fwcd. All rights reserved.
//

import Foundation
import CoreGraphics

class Transition {
	var current: CGPoint
	var speed: CGFloat
	let goal: CGPoint
	let moveables: [Moveable]
	
	init(start: CGPoint, goal: CGPoint, speed: CGFloat, moveables: [Moveable]) {
		current = start
		self.goal = goal
		self.speed = speed
		self.moveables = moveables
	}
	
	func advance() {
		let d = getDeltaVec()
		
		for moveable in moveables {
			moveable.move(by: d)
		}
		
		current = CGPoint(x: current.x + d.dx, y: current.y + d.dy)
	}
	
	private func getDeltaVec() -> CGVector {
		return CGVector(dx: delta(goal.x - current.x), dy: delta(goal.y - current.y))
	}
	
	private func delta(_ n: CGFloat) -> CGFloat {
		let step = min(n, speed)
		return (n > 0) ? step : (n < 0 ? -step : 0)
	}
	
	func inProgress() -> Bool {
		return current != goal
	}
}
