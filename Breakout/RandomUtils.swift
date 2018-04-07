//
//  RandomUtils.swift
//  Breakout
//
//  Created by Fredrik on 06.04.18.
//  Copyright © 2018 fwcd. All rights reserved.
//

import Foundation
import CoreGraphics

func randomInt() -> Int {
	return Int(arc4random_uniform(UINT32_MAX))
}

/**
 * Generates a random integer from (inclusive)
 * to (exclusive) a number.
 */
func randomInt(from: Int, to: Int) -> Int {
	return Int(arc4random_uniform(UInt32(to - from))) + from
}

/**
 * Generates a random float inside the range from 0 (inclusive)
 * to 1 (exclusive).
 */
func randomFloat() -> Float {
	return Float(arc4random_uniform(UINT32_MAX)) / Float(UINT32_MAX)
}

/**
 * Generates a random float from (inclusive)
 * to (exclusive) a number.
 */
func randomFloat(from: Float, to: Float) -> Float {
	return (randomFloat() * (to - from)) + from
}

/**
 * Generates a random CGFloat inside the range from 0 (inclusive)
 * to 1 (exclusive).
 */
func randomCGFloat() -> CGFloat {
	return CGFloat(arc4random_uniform(UINT32_MAX)) / CGFloat(UINT32_MAX)
}

/**
 * Generates a random CGFloat from (inclusive)
 * to (exclusive) a number.
 */
func randomCGFloat(from: CGFloat, to: CGFloat) -> CGFloat {
	return (randomCGFloat() * (to - from)) + from
}

/**
 * Generates a random double inside the range from 0 (inclusive)
 * to 1 (exclusive).
 */
func randomDouble() -> Double {
	return Double(arc4random_uniform(UINT32_MAX)) / Double(UINT32_MAX)
}

/**
 * Generates either true or false with probabilities
 * of approximately 0.5 each.
 */
func randomBool() -> Bool {
	return arc4random_uniform(2) == 0
}

/**
 * Generates a random angle in radians.
 */
func randomAngleRad() -> CGFloat {
	return randomCGFloat(from: 0, to: 2 * CGFloat.pi)
}

func toRadians(degrees: CGFloat) -> CGFloat {
	return (degrees / 360.0) * 2 * CGFloat.pi
}

func toDegrees(radians: CGFloat) -> CGFloat {
	return (radians / (2 * CGFloat.pi)) * 360.0
}

func randomAngleRad(betweenDeg startDeg: CGFloat, andDeg endDeg: CGFloat) -> CGFloat {
	return randomCGFloat(from: toRadians(degrees: startDeg), to: toRadians(degrees: endDeg))
}

/**
 * Generates a CGVector pointing in a
 * random direction with a given length.
 */
func randomCGVector(length: CGFloat) -> CGVector {
	let angle: CGFloat = randomAngleRad()
	return CGVector(dx: length * CGFloat(cos(angle)), dy: length * CGFloat(sin(angle)))
}
