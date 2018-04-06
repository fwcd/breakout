//
//  Level3.swift
//  Breakout
//
//  Created by Fredrik on 06.04.18.
//  Copyright © 2018 fwcd. All rights reserved.
//

import Foundation

class Level3: BasicLevel {
	override var yBricks: Int {
		get { return 9 }
	}
	override var nextLevel: Level? {
		get { return Level3() } // TODO: Replace with next level as soon as it is available
	}
	
	override func sampleBrick() -> Brick {
		switch (arc4random_uniform(8)) {
		case 0:
			return HardBrick(resistance: 12)
		case 1:
			return HardBrick(resistance: 8)
		case 2:
			return HardBrick(resistance: 6)
		case 3:
			return UnbreakableBrick()
		default:
			return BasicBrick()
		}
	}
}
