//
//  GrowBallItem.swift
//  Breakout
//
//  Created by Fredrik on 08.04.18.
//  Copyright © 2018 fwcd. All rights reserved.
//

import Foundation
import UIKit

class GrowBallItem: BasicItem {
	override func loadTexture() -> UIImage? {
		return #imageLiteral(resourceName: "GrowBallItemTexture")
	}
	
	override func onPickUp() {
		game.addToAllBalls(effect: GrowBallEffect(growFactor: 2), forSeconds: 10)
	}
}
