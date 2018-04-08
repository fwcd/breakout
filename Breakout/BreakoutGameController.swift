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
 * user input to control the game.
 */
class BreakoutGameController: UIViewController {
	private let settingsModel = SettingsModel()
	private let preferredFPS = 30 // TODO: Use 60 FPS, but adjust game speed accordingly
	private var displayLink: CADisplayLink!
	private var loaded: Bool = false
	private(set) var game: BreakoutGame!
	override var prefersStatusBarHidden: Bool {
		get { return true }
	}
	
	override func viewWillAppear(_ animated: Bool) {
		if (!loaded) {
			game = BreakoutGame(controller: self, initialBallSpeed: 9, initialBallCount: 1)
			game.testModeEnabled = settingsModel.testModeEnabled
			game.backgroundImage = settingsModel.backgroundImage
			
			// Initialize gameloop
			
			displayLink = CADisplayLink(target: self, selector: #selector(gameLoop))
			if #available(iOS 10.0, *) {
				displayLink.preferredFramesPerSecond = preferredFPS
			}
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
			game.update()
			
			for ball in game.balls {
				ball.update(game: game)
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

