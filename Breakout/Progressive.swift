//
//  Progressive.swift
//  Breakout
//
//  Created by Fredrik on 11.04.18.
//  Copyright © 2018 fwcd. All rights reserved.
//

import Foundation

protocol Progressive {
	func advance()
	
	func isFinished() -> Bool
}
