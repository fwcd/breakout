//
//  DateSpan.swift
//  Breakout
//
//  Created by Fredrik on 08.04.18.
//  Copyright © 2018 fwcd. All rights reserved.
//

import Foundation

/**
 * A closed date interval. In pratice, it is
 * equivalent to DateInterval, but does not
 * require the iOS 10 SDK.
 */
struct DateSpan {
	var start: Date
	var end: Date
	var duration: TimeInterval {
		get { return end.timeIntervalSince(start) }
	}
	
	init() {
		let now = Date()
		start = now
		end = now
	}
	
	init(start: Date, duration: TimeInterval) {
		self.start = start
		end = start.addingTimeInterval(duration)
	}
	
	init(start: Date, end: Date) {
		self.start = start
		self.end = end
	}
	
	func hasPassed() -> Bool {
		let now = Date()
		return now > end
	}
	
	/**
	 * Fetches the progress in percent.
	 * The returned value will be between 0 and 1
	 * (both inclusive).
	 */
	func getProgress() -> Double {
		let now = Date()
		return clamp(now.timeIntervalSince(start) / end.timeIntervalSince(start), min: 0, max: 1)
	}
}
