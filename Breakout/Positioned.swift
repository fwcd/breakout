//
//  Positioned.swift
//  Breakout
//
//  Created by Fredrik on 07.04.18.
//  Copyright © 2018 fwcd. All rights reserved.
//

import Foundation
import CoreGraphics

/**
 * An object that has a two-dimensional position.
 */
protocol Positioned {
	var pos: CGPoint { get }
}
