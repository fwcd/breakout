//
//  BreakoutGameController.swift
//  Breakout
//
//  Created by Fredrik on 03.04.18.
//  Copyright © 2018 fwcd. All rights reserved.
//

import UIKit

/**
 * The controller that handles events and
 * user input to control the game. Furthermore
 * does it contain the game loop.
 */
class BreakoutGameController: UIViewController {
	private let settingsModel = SettingsModel()
	private var loaded: Bool = false
	private(set) var game: BreakoutGame!
	override var prefersStatusBarHidden: Bool {
		get { return true }
	}
	
	private var displayLink: CADisplayLink!
	private var tps = 60
	private var tickDelay: TimeInterval!
	private var lastTick = Date()
	
	override func viewWillAppear(_ animated: Bool) {
		if (!loaded) {
			game = BreakoutGame(controller: self, initialBallSpeed: 9, initialBallCount: 1)
			game.testModeEnabled = settingsModel.testModeEnabled
			game.backgroundImage = settingsModel.backgroundImage
			
			// Initialize gameloop
			
			tickDelay = 1.0 / Double(tps)
			displayLink = CADisplayLink(target: self, selector: #selector(gameLoop))
			displayLink.add(to: .main, forMode: .commonModes)
			loaded = true
		}
	}
	
	override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
		let touch: UITouch! = touches.first
		game.paddle.moveTo(x: touch.location(in: view).x)
	}
	
	@objc
	private func gameLoop() {
		if !view.isHidden {
			let now = Date()
			if now.timeIntervalSince(lastTick) > tickDelay {
				game.tick()
				lastTick = now
			}
			
			view.setNeedsDisplay()
		}
	}
	
	@IBAction
	func returnToGame(sender: UIStoryboardSegue) {}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		(segue.destination as? SettingsNavigationController)?.settings?.setModel(settingsModel)
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
}

