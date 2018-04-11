//
//  GridPosition.swift
//  Breakout
//
//  Created by Fredrik on 11.04.18.
//  Copyright © 2018 fwcd. All rights reserved.
//

import Foundation
import CoreGraphics

struct GridPosition {
	let x: Int
	let y: Int
	
	init(x: Int, y: Int) {
		self.x = x
		self.y = y
	}
	
	func distTo(pos other: GridPosition) -> CGFloat {
		return CGFloat(sqrt(pow(Double(other.x - x), 2) + pow(Double(other.y - y), 2)))
	}
	
	func distTo(point other: CGPoint) -> CGFloat {
		return CGFloat(sqrt(pow(Double(other.x - CGFloat(x)), 2) + pow(Double(other.y - CGFloat(y)), 2)))
	}
	
	func toCGVector() -> CGVector {
		return CGVector(dx: CGFloat(x), dy: CGFloat(y))
	}
	
	func toCGPoint() -> CGPoint {
		return CGPoint(x: x, y: y)
	}
}
