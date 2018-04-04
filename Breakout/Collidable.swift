//
//  Collidable.swift
//  Breakout
//
//  Created by Fredrik on 03.04.18.
//  Copyright © 2018 fwcd. All rights reserved.
//

import Foundation
import CoreGraphics

protocol Collidable {
	var velocity: CGVector { get set }
	
	func collisionWith(ball: Ball) -> Collision?
	
	func destroyUponHit() -> Bool
}
