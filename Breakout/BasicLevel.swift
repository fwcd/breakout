//
//  BasicLevel.swift
//  Breakout
//
//  Created by Fredrik on 04.04.18.
//  Copyright © 2018 fwcd. All rights reserved.
//

import Foundation
import CoreGraphics

class BasicLevel: Level {
	var bricks: [Brick] = [Brick]()
	var nextLevel: Level? {
		get { return nil }
	}
	var yBricks: Int {
		get { return 4 }
	}
	private var brickCounter: Int = 0
	
	func destroyBrick(at index: Int) {
		let brick = bricks.remove(at: index)
		if (brick.affectsLevelCounter()) {
			brickCounter -= 1
		}
	}
	
	func addBrick(bounds: CGRect) {
		let brick = sampleBrick()
		brick.placeIn(bounds: bounds)
		bricks.append(brick)
		if (brick.affectsLevelCounter()) {
			brickCounter += 1
		}
	}
	
	func sampleBrick() -> Brick {
		return Brick()
	}
	
	func move(by vec: CGVector) {
		for brick in bricks {
			brick.move(by: vec)
		}
	}
	
	func render(to context: CGContext) {
		for brick in bricks {
			brick.render(to: context)
		}
	}
	
	func isCompleted() -> Bool {
		return brickCounter <= 0
	}
}
