//
//  Level1.swift
//  Breakout
//
//  Created by Fredrik on 04.04.18.
//  Copyright © 2018 fwcd. All rights reserved.
//

import Foundation

class Level1: BasicLevel {
	override var yBricks: Int {
		get { return 4 }
	}
	override var nextLevel: Level? {
		get { return Level2() }
	}
	
	override func sampleBrick() -> Brick {
		switch (arc4random_uniform(6)) {
		case 0:
			return HardBrick(resistance: 1)
		default:
			return Brick()
		}
	}
}
