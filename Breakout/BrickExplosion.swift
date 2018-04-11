//
//  BrickExplosion.swift
//  Breakout
//
//  Created by Fredrik on 11.04.18.
//  Copyright © 2018 fwcd. All rights reserved.
//

import Foundation
import CoreGraphics

class BrickExplosion: Progressive {
	let pos: GridPosition
	let radius: CGFloat
	let game: BreakoutGame
	
	init(at pos: GridPosition, withRadius radius: CGFloat, inGame game: BreakoutGame) {
		self.pos = pos
		self.radius = radius
		self.game = game
	}
	
	func advance() {
		// TODO: See comment in isFinished()
		explode()
	}
	
	private func explode() {
		let filter: (Brick) -> Bool = {(b) in return b.gridPosition.distTo(pos: self.pos) > self.radius }
		
		game.currentLevel.filterBricks(filter)
		game.nextLevel?.filterBricks(filter)
	}
	
	func isFinished() -> Bool {
		// TODO: Make explosiions display an animation instead
		// of instantly finishing
		return true
	}
}
