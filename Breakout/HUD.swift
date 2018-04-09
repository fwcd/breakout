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
	var score = Holder<Int>(with: 0)
	var levelIndex = Holder<Int>(with: 0)
	
	init(pos: CGPoint, color: UIColor, fontSize: CGFloat) {
		self.pos = pos
		self.color = color
		self.fontSize = fontSize
	}
	
	convenience init(x: CGFloat, y: CGFloat, color: UIColor, fontSize: CGFloat) {
		self.init(pos: CGPoint(x: x, y: y), color: color, fontSize: fontSize)
	}
	
	func getLine() -> String {
		return "Score: \(score.value) - Level: \(levelIndex.value)"
	}
	
	func render(to context: CGContext) {
		let nsStr = getLine() as NSString
		let attributes = [
			NSAttributedStringKey.font : UIFont.systemFont(ofSize: fontSize),
			NSAttributedStringKey.foregroundColor : color
		]
		nsStr.draw(at: pos, withAttributes: attributes)
	}
}
