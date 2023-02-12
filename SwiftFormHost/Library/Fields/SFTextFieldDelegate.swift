//
//  SFTextFieldDelegate.swift
//  SwiftFormHost
//
//  Created by ezen on 12/02/2023.
//

import Foundation
import UIKit

@objc protocol SFTextFieldDelegate {
	
	@objc optional func shouldDisplayErrorLabels(_ instance: SFTextField, _ textField: UITextField) -> Bool
	
	@objc optional func errorLabelOffset(_ instance: SFTextField, _ textField: UITextField) -> Offset
}
