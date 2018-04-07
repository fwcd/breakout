//
//  Circular.swift
//  Breakout
//
//  Created by Fredrik on 07.04.18.
//  Copyright © 2018 fwcd. All rights reserved.
//

import Foundation
import CoreGraphics

/**
 * A positioned object with the shape of a circle.
 */
protocol Circular: Positioned {
	var radius: CGFloat { get }
}
