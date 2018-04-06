//
//  HUD.swift
//  Breakout
//
//  Created by Fredrik on 06.04.18.
//  Copyright © 2018 fwcd. All rights reserved.
//

import Foundation
import UIKit
import CoreGraphics

class HUD: Rendereable {
	let pos: CGPoint
	let color: UIColor
	let fontSize: CGFloat
	private var score: Int = 0
	private var levelIndex: Int = 0
	
	init(pos: CGPoint, color: UIColor, fontSize: CGFloat) {
		self.pos = pos
		self.color = color
		self.fontSize = fontSize
	}
	
	convenience init(x: CGFloat, y: CGFloat, color: UIColor, fontSize: CGFloat) {
		self.init(pos: CGPoint(x: x, y: y), color: color, fontSize: fontSize)
	}
	
	private func getLine() -> String {
		return "Score: \(score) - Level: \(levelIndex)"
	}
	
	func render(to context: CGContext) {
		let nsStr = getLine() as NSString
		let attributes = [
			NSFontAttributeName : UIFont.systemFont(ofSize: fontSize),
			NSForegroundColorAttributeName : color
		]
		nsStr.draw(at: pos, withAttributes: attributes)
	}
	
	func incrementScore() { score += 1 }
	
	func resetScore() { score = 0 }
	
	func incrementLevelIndex() { levelIndex += 1 }
	
	func resetLevelIndex() { levelIndex = 0 }
}
