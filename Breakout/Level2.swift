//
//  Level2.swift
//  Breakout
//
//  Created by Fredrik on 04.04.18.
//  Copyright © 2018 fwcd. All rights reserved.
//

import Foundation

class Level2: BasicLevel {
	override var yBricks: Int {
		get { return 8 }
	}
	override var nextLevel: Level? {
		get { return Level3() }
	}
	
	override func sampleBrick() -> Brick {
		switch (arc4random_uniform(8)) {
		case 0:
			return HardBrick(resistance: 4)
		case 1:
			return HardBrick(resistance: 3)
		case 2:
			return HardBrick(resistance: 3)
		case 3:
			return HardBrick(resistance: 2)
		default:
			return BasicBrick()
		}
	}
}
