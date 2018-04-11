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
		get { return 6 }
	}
	override var nextLevel: Level? {
		get { return Level3() } // TODO: Replace with next level as soon as it is available
	}
	
	override func sampleBrick() -> Brick {
		switch randomInt(from: 0, to: 8) {
		case 0:
			return ExplodingBrick(radius: 3)
		case 1:
			return HardBrick(resistance: 4)
		case 2:
			return HardBrick(resistance: 3)
		case 3:
			return UnbreakableBrick()
		case 4:
			return ItemBrick(item: sampleItem())
		default:
			return BasicBrick()
		}
	}
	
	override func sampleItem() -> Item {
		switch randomInt(from: 0, to: 2) {
		case 0:
			return GrowBallItem()
		default:
			return SpawnBallItem()
		}
	}
}
