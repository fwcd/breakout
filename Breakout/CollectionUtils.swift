//
//  CollectionUtils.swift
//  Breakout
//
//  Created by Fredrik on 07.04.18.
//  Copyright © 2018 fwcd. All rights reserved.
//

import Foundation

func remove<E: Equatable>(_ element: E, from array: inout [E]) {
	var i: Int = 0
	for other in array {
		if other == element {
			array.remove(at: i)
			return
		}
		i += 1
	}
}
