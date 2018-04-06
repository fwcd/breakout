//
//  Geometry.swift
//  Breakout
//
//  Created by Fredrik on 06.04.18.
//  Copyright © 2018 fwcd. All rights reserved.
//

import Foundation
import CoreGraphics

func clamp<T: Comparable>(_ v: T, min minValue: T, max maxValue: T) -> T {
	if v > maxValue {
		return maxValue
	} else if v < minValue {
		return minValue
	} else {
		return v
	}
}

extension CGPoint {
	func add(_ vec: CGVector) -> CGPoint {
		return CGPoint(x: x + vec.dx, y: y + vec.dy)
	}
	
	mutating func addMutate(_ vec: CGVector) {
		x += vec.dx
		y += vec.dy
	}
	
	func toVector() -> CGVector {
		return CGVector(dx: x, dy: y)
	}
	
	func nearestPoint(inRect rect: CGRect) -> CGPoint {
		return CGPoint(
			x: clamp(x, min: rect.minX, max: rect.maxX),
			y: clamp(y, min: rect.minY, max: rect.maxY)
		)
	}
	
	func distTo(point other: CGPoint) -> CGFloat {
		return sqrt(pow(other.x - x, 2) + pow(other.y - y, 2))
	}
	
	func to(point other: CGPoint) -> CGVector {
		return CGVector(dx: other.x - x, dy: other.y - y)
	}
}

extension CGVector {
	init(angleRad: CGFloat, length: CGFloat) {
		dx = cos(angleRad) * length
		dy = sin(angleRad) * length
	}
	
	mutating func addMutate(_ other: CGVector) {
		dx += other.dx
		dy += other.dy
	}
	
	func add(_ other: CGVector) -> CGVector {
		return CGVector(dx: dx + other.dx, dy: dy + other.dy)
	}
	
	mutating func subMutate(_ other: CGVector) {
		dx -= other.dx
		dy -= other.dy
	}
	
	func sub(_ other: CGVector) -> CGVector {
		return CGVector(dx: dx - other.dx, dy: dy - other.dy)
	}
	
	mutating func scaleMutate(by factor: CGFloat) {
		dx *= factor
		dy *= factor
	}
	
	func scale(by factor: CGFloat) -> CGVector {
		return CGVector(dx: dx * factor, dy: dy * factor)
	}
	
	func length() -> CGFloat {
		return sqrt((dx * dx) + (dy * dy))
	}
	
	mutating func normalizeMutate() {
		let len = length()
		dx /= len
		dy /= len
	}
	
	func invertX() -> CGVector {
		return CGVector(dx: -dx, dy: dy)
	}
	
	mutating func invertXMutate() {
		dx *= -1
	}
	
	func invertY() -> CGVector {
		return CGVector(dx: dx, dy: -dy)
	}
	
	mutating func invertYMutate() {
		dy *= -1
	}
	
	func invert() -> CGVector {
		return CGVector(dx: -dx, dy: -dy)
	}
	
	func normalize() -> CGVector {
		let len = length()
		return CGVector(dx: dx / len, dy: dy / len)
	}
	
	func toPoint() -> CGPoint {
		return CGPoint(x: dx, y: dy)
	}
}
