//
//  SpawnBallItem.swift
//  Breakout
//
//  Created by Fredrik on 07.04.18.
//  Copyright © 2018 fwcd. All rights reserved.
//

import Foundation
import UIKit

class SpawnBallItem: BasicItem {
	override func loadTexture() -> UIImage? {
		return #imageLiteral(resourceName: "SpawnBallItemTexture")
	}
	
	override func onPickUp() {
		game.spawnBall()
	}
}
