//
//  Holder.swift
//  Breakout
//
//  Created by Fredrik on 06.04.18.
//  Copyright © 2018 fwcd. All rights reserved.
//

import Foundation

class Holder<T> {
	private var storedValue: T
	private var listeners = [(T) -> ()]()
	var value: T {
		get { return storedValue }
		set {
			storedValue = newValue
			fireListeners(with: newValue)
		}
	}
	
	init(with value: T) {
		storedValue = value
	}
	
	func add(listener: @escaping (T) -> ()) {
		listeners.append(listener)
	}
	
	private func fireListeners(with value: T) {
		for listener in listeners {
			listener(value)
		}
	}
}
