//
//  Holder.swift
//  Breakout
//
//  Created by Fredrik on 06.04.18.
//  Copyright © 2018 fwcd. All rights reserved.
//

import Foundation

class Holder<T> {
	var value: T
	
	init(with value: T) {
		self.value = value
	}
}
