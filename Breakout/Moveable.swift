//
//  Moveable.swift
//  Breakout
//
//  Created by Fredrik on 04.04.18.
//  Copyright © 2018 fwcd. All rights reserved.
//

import Foundation
import CoreGraphics

/**
 * An object that can be moved.
 */
protocol Moveable {
	func move(by vec: CGVector)
}
