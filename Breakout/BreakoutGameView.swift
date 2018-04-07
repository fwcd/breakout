//
//  BreakoutGameView.swift
//  Breakout
//
//  Created by Fredrik on 07.04.18.
//  Copyright © 2018 fwcd. All rights reserved.
//

import Foundation
import UIKit

class BreakoutGameView: UIView {
	private var game: BreakoutGame!
	
	func setGame(_ game: BreakoutGame) {
		self.game = game
	}
	
	override func draw(_ rect: CGRect) {
		guard let context: CGContext = UIGraphicsGetCurrentContext() else { return }
		game.render(to: context)
	}
}
