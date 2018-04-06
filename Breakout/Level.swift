//
//  Level.swift
//  Breakout
//
//  Created by Fredrik on 04.04.18.
//  Copyright © 2018 fwcd. All rights reserved.
//

import Foundation
import CoreGraphics

/**
 * A state of the game that encapsulates how many
 * layers and which bricks should be used.
 */
protocol Level: Moveable, Rendereable {
	var bricks: [Brick] { get }
	var nextLevel: Level? { get }
	var yBricks: Int { get }
	
	func destroyBrick(at index: Int)
	
	func addBrick(bounds: CGRect)
	
	func isCompleted() -> Bool
}
