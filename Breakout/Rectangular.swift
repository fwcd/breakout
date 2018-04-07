//
//  Rectangular.swift
//  Breakout
//
//  Created by Fredrik on 07.04.18.
//  Copyright © 2018 fwcd. All rights reserved.
//

import Foundation
import CoreGraphics

/**
 * A positioned object with the shape of a rectangle.
 */
protocol Rectangular: Positioned {
	var bounds: CGRect { get }
}

extension Rectangular {
	var pos: CGPoint {
		get { return bounds.origin }
	}
}
