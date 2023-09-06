//
//  SFTextFieldDelegate.swift
//  SwiftFormHost
//
//  Created by ezen on 12/02/2023.
//

import Foundation
import UIKit

@objc
protocol SFTextFieldDelegate {
	
	/**
	 Asks the delegate whether to begin editing in the specified text field.
	 */
	@objc optional func textFieldShouldBeginEditing(_ textField: SFBaseTextField) -> Bool
	
	/**
	 Tells the delegate when editing begins in the specified text field.
	 */
	@objc optional func textFieldDidBeginEditing(_ textField: SFBaseTextField)
	
	/**
	 Asks the delegate whether to stop editing in the specified text field.
	 */
	@objc optional func textFieldShouldEndEditing(_ textField: SFBaseTextField) -> Bool
	
	/**
	 Tells the delegate when editing stops for the specified text field, and the reason it stopped.
	 */
	@objc optional func textFieldDidEndEditing(_ textField: SFBaseTextField)

	/**
	 Asks the delegate whether to process the pressing of the Return button for the text field.
	 */
	@objc optional func textFieldShouldReturn(_ textField: SFBaseTextField) -> Bool
	
	/**
	 Asks the delegate the UIFont to apply in the specified text field
	 */
	@objc optional func textFieldFont(_ textField: SFBaseTextField) -> UIFont
	
	/**
	 Asks the delegate the UIFont to apply to the specified text field error
	 */
	@objc optional func textFieldErrorFont(_ textField: SFBaseTextField) -> UIFont
	
	/**
	 Asks the delegate the text alignment to apply in the specified text field
	 */
	@objc optional func textFieldAlignment(_ textField: SFBaseTextField) -> NSTextAlignment

	// func fieldsRules() -> [SwiftFormRule] // array of rules
}
