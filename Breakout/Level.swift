//
//  Level.swift
//  Breakout
//
//  Created by Fredrik on 04.04.18.
//  Copyright © 2018 fwcd. All rights reserved.
//

import Foundation
import CoreGraphics

protocol Level : Moveable, Rendereable {
	var bricks: [Brick] { get }
	var nextLevel: Level? { get }
	
	func destroyBrick(at index: Int)
	
	func addBrick(bounds: CGRect)
	
	func isCompleted() -> Bool
}
