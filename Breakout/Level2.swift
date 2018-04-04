//
//  Level2.swift
//  Breakout
//
//  Created by Fredrik on 04.04.18.
//  Copyright © 2018 fwcd. All rights reserved.
//

import Foundation

class Level2 : BasicLevel {
	/*override var nextLevel: Level? {
		get { return Level3() }
	}*/
	
	override func sampleBrick() -> Brick {
		switch (arc4random_uniform(6)) {
		case 0:
			return HardBrick(resistance: 5)
		case 1:
			return HardBrick(resistance: 3)
		case 2:
			return UnbreakableBrick()
		default:
			return Brick()
		}
	}
}
