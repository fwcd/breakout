//
//  GeometryUtils.swift
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

fileprivate func circleHits(x: CGFloat, ofRect rect: CGRect, withRadius radius: CGFloat) -> Bool {
	return abs(x - clamp(x, min: rect.minX, max: rect.maxX)) <= radius
}

fileprivate func circleHits(y: CGFloat, ofRect rect: CGRect, withRadius radius: CGFloat) -> Bool {
	return abs(y - clamp(y, min: rect.minY, max: rect.maxY)) <= radius
}

func collisionOf(rect: Rectangular, withMovingCircle circle: Circular & Moving) -> BallCollision? {
	let newPos = circle.predictPos()
	let xCollides =
			!circleHits(x: circle.pos.x, ofRect: rect.bounds, withRadius: circle.radius)
			&& circleHits(x: newPos.x, ofRect: rect.bounds, withRadius: circle.radius)
			&& circleHits(y: circle.pos.y, ofRect: rect.bounds, withRadius: circle.radius)
			&& circleHits(y: newPos.y, ofRect: rect.bounds, withRadius: circle.radius)
	let yCollides =
			!circleHits(y: circle.pos.y, ofRect: rect.bounds, withRadius: circle.radius)
			&& circleHits(y: newPos.y, ofRect: rect.bounds, withRadius: circle.radius)
			&& circleHits(x: circle.pos.x, ofRect: rect.bounds, withRadius: circle.radius)
			&& circleHits(x: newPos.x, ofRect: rect.bounds, withRadius: circle.radius)
	
	if xCollides && !yCollides {
		return InvertXCollision()
	} else if yCollides && !xCollides {
		return InvertYCollision()
	} else if xCollides && yCollides {
		return InvertCollision()
	} else {
		return nil
	}
}

func collisionOf(movingCircle circle: Circular & Moving, withMovingCircle otherCircle: Circular & Moving) -> BallCollision? {
	if circle.pos.distTo(point: otherCircle.pos) < (circle.radius + otherCircle.radius) {
		return VelocitySwapCollision()
	} else {
		return nil
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

extension CGRect {
	var center: CGPoint {
		get { return CGPoint(x: minX + (width / 2), y: minY + (height / 2)) }
	}
	
	func contains(_ circular: Circular) -> Bool {
		return contains(circular, withPadding: 0)
	}
	
	func contains(_ circular: Circular, withPadding padding: CGFloat) -> Bool {
		let pos = circular.pos
		let r = circular.radius + padding
		return (pos.x - r) > minX
			&& (pos.x + r) < maxX
			&& (pos.y - r) > minY
			&& (pos.y + r) < maxY
	}
}

extension CGVector {
	init(angleRad: CGFloat, length: CGFloat) {
		self.init()
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
	
	mutating func invertMutate() {
		dx *= -1
		dy *= -1
	}
	
	func normalize() -> CGVector {
		let len = length()
		return CGVector(dx: dx / len, dy: dy / len)
	}
	
	func toPoint() -> CGPoint {
		return CGPoint(x: dx, y: dy)
	}
}
