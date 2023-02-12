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
