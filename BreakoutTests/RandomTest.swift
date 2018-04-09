//
//  RandomTest.swift
//  Breakout
//
//  Created by Fredrik on 06.04.18.
//  Copyright © 2018 fwcd. All rights reserved.
//

import XCTest
@testable import Breakout

class RandomTest: XCTestCase {
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test() {
		XCTAssertEqual(
			getProbability(
				of: {() -> Bool in return randomBool()},
				expected: true,
				tests: 100),
			0.5,
			accuracy: 0.1)
		XCTAssertEqual(
			getProbability(
				of: {() -> Int in return randomInt(from: -5, to: 4)},
				expected: -2,
				tests: 100),
			1.0 / 8.0,
			accuracy: 0.1)
    }
    
	func getProbability<T: Equatable>(of testedFunc: () -> T, expected: T, tests: Int) -> Double {
		var successes: Int = 0
		var failures: Int = 0
		
		for _ in 0..<tests {
			if testedFunc() == expected {
				successes += 1
			} else {
				failures += 1
			}
		}
		
		return Double(successes) / Double(successes + failures)
	}
}
