//
//  Brick.swift
//  Breakout
//
//  Created by Fredrik on 03.04.18.
//  Copyright © 2018 fwcd. All rights reserved.
//

import Foundation
import UIKit
import CoreGraphics

/**
 * A rectangular object in the game
 * that responds to collisions with balls.
 */
protocol Brick: Collidable, Rendereable {
	var bounds: CGRect! { get }
	
	func placeIn(bounds: CGRect);
	
	func placeAt(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat);
	
	func move(by vec: CGVector);
	
	func getColor() -> CGColor;
	
	func destroyUponHit() -> Bool;
	
	func affectsLevelCounter() -> Bool;
}
