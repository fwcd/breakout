//
//  CollectionUtils.swift
//  Breakout
//
//  Created by Fredrik on 07.04.18.
//  Copyright © 2018 fwcd. All rights reserved.
//

import Foundation

func removeFromArray<E: Equatable>(_ element: E, from array: inout [E]) {
	for (i, other) in array.enumerated().reversed() {
		if other == element {
			array.remove(at: i)
			return
		}
	}
}
