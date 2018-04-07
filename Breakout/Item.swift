//
//  Item.swift
//  Breakout
//
//  Created by Fredrik on 06.04.18.
//  Copyright © 2018 fwcd. All rights reserved.
//

import Foundation
import CoreGraphics

protocol Item: Circular, Rendereable, BallCollidable {
	func setGame(_ game: BreakoutGame)
	
	func fall()
	
	func collidesWith(paddle: Paddle) -> Bool
	
	func place(at pos: CGPoint, withSpeed speed: CGFloat, andRadius radius: CGFloat)
	
	func onPickUp()
}
