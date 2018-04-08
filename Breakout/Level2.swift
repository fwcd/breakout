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
		get { return 4 }
	}
	override var nextLevel: Level? {
		get { return Level3() }
	}
	
	override func sampleBrick() -> Brick {
		switch randomInt(from: 0, to: 3) {
		case 0:
			return HardBrick(resistance: 2)
		case 1:
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
