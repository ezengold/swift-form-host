//
//  SFTextFieldParams.swift
//  SwiftFormHost
//
//  Created by ezen on 30/08/2023.
//

import Foundation
import SwiftUI

class SFTextFieldParams: ObservableObject {
	@Published var height: CGFloat = 40
	
	@Published var name: String = ""
	
	@Published var value: String = ""
	
	@Published var error: String = ""
	
	@Published var placeholder: String = ""
	
	@Published var keyboardType: UIKeyboardType = .default
	
	@Published var iconLeft: UIImage? = nil
	
	@Published var iconRight: UIImage? = nil
	
	var onClickLeft: (() -> Void)? = nil
	
	var onClickRight: (() -> Void)? = nil
	
	@Published var contentInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
	
	@Published var font: UIFont = UIFont.systemFont(ofSize: 15)
	
	@Published var errorFont: UIFont = UIFont.systemFont(ofSize: 12)
	
	@Published var errorAlignment: TextAlignment = .trailing
	
	@Published var backgroundColor: UIColor = .clear
	
	@Published var textColor: UIColor = .label
	
	@Published var errorTextColor: UIColor = .red
	
	@Published var tintColor: UIColor = .label
	
	@Published var cornerRadius: CGFloat = 0
	
	@Published var borderWidth: CGFloat = 0
	
	@Published var borderColor: UIColor = .clear
}
