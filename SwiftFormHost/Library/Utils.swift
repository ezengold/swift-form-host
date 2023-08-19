//
//  Utils.swift
//  SwiftFormHost
//
//  Created by ezen on 12/02/2023.
//

import Foundation

@objcMembers
@objc public class Offset: NSObject {
	public let x: CGFloat
	public let y: CGFloat
	
	override init() {
		self.x = 0
		self.y = 0
	}
	
	init(x: CGFloat, y: CGFloat) {
		self.x = x
		self.y = y
	}
}

public struct SFHelpers {
	static func isEqual(a: Any, b: Any) -> Bool {
		if a is Character {
			return a as! Character == b as! Character
		} else if a is String {
			return a as! String == b as! String
		} else if a is Int {
			return a as! Int == b as! Int
		} else if a is Float {
			return a as! Float == b as! Float
		} else if a is Double {
			return a as! Double == b as! Double
		} else if a is Bool {
			return a as! Bool == b as! Bool
		} else {
			return false
		}
	}
}
