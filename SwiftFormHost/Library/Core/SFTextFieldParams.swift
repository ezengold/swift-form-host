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
	
	@Published var errorIcon: UIImage? = nil
    
    @Published var iconLeftColor: UIColor = .label
    
    @Published var iconRightColor: UIColor = .label
    
    @Published var iconLeftRenderingMode: Image.TemplateRenderingMode = .template
    
    @Published var iconRightRenderingMode: Image.TemplateRenderingMode = .template
	
	@Published var errorIconRenderingMode: Image.TemplateRenderingMode = .template
	
	var onClickLeft: (() -> Void)? = nil
	
	var onClickRight: (() -> Void)? = nil
	
	@Published var contentInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
	
	@Published var font: UIFont = UIFont.systemFont(ofSize: 15)
	
	@Published var textAlignment: TextAlignment = .leading
	
	@Published var errorFont: UIFont = UIFont.systemFont(ofSize: 12)
	
	@Published var errorAlignment: TextAlignment = .trailing
	
	@Published var backgroundColor: UIColor = .clear
	
	@Published var textColor: UIColor = .label
	
	@Published var errorTextColor: UIColor = .red
	
	@Published var tintColor: UIColor = .label
	
	@Published var cornerRadius: CGFloat = 0
	
	@Published var borderWidth: CGFloat = 0
	
	@Published var borderColor: UIColor = .clear
	
	@Published var showErrorLabel: Bool = true
	
	@Published var showErrorBorder: Bool = true
    
    @Published var isSecuredTextEntry: Bool = false
    
    @Published var shouldEnableToggleSecureMode: Bool = true
}
