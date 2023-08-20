//
//  SFTextFieldDelegate.swift
//  SwiftFormHost
//
//  Created by ezen on 12/02/2023.
//

import Foundation
import UIKit

@objc
protocol SFTextFieldDelegate: UITextFieldDelegate {
	
	@objc optional func shouldDisplayErrorLabels(_ instance: SFTextField, _ textField: UITextField) -> Bool
	
	// func fieldsRules() -> [SwiftFormRule] // array of rules
}
