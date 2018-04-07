//
//  SpawnBallItem.swift
//  Breakout
//
//  Created by Fredrik on 07.04.18.
//  Copyright © 2018 fwcd. All rights reserved.
//

import Foundation

class SpawnBallItem: BasicItem {
	override init() {
		super.init()
		texture = #imageLiteral(resourceName: "SpawnBallItemTexture")
	}
	
	override func onPickUp() {
		game.spawnBall()
	}
}
