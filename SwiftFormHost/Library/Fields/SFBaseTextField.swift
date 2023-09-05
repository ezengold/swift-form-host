//
//  SFBaseTextField.swift
//  SwiftFormHost
//
//  Created by Loic HACHEME on 05/09/2023.
//

import UIKit
import SwiftUI

internal class SFBaseTextField: UIView {
    
    @ObservedObject var params = SFTextFieldParams()
    
    @IBInspectable var height: CGFloat = 40 {
        didSet {
            params.height = self.height
        }
    }
    
    @IBInspectable var name: String = "" {
        didSet {
            params.name = self.name
        }
    }
    
    @IBInspectable var value: String = "" {
        didSet {
            params.value = self.value
        }
    }
    
    @IBInspectable var placeholder: String = "" {
        didSet {
            params.placeholder = self.placeholder
        }
    }
    
    @IBInspectable var fieldFont: UIFont  {
        get {
            params.font
        }
        set {
            params.font = newValue
        }
    }
    
    // MARK: - Error attributes
    var error: String = ""  {
        didSet {
            params.error = self.error
        }
    }
    
    @IBInspectable var errorFont: UIFont = UIFont.systemFont(ofSize: 12)  {
        didSet {
            params.errorFont = self.errorFont
        }
    }
    
    var errorAlign: TextAlignment = .trailing  {
        didSet {
            params.errorAlignment = self.errorAlign
        }
    }
    
    @IBInspectable var showErrorLabel: Bool = true  {
        didSet {
            params.showErrorLabel = self.showErrorLabel
        }
    }
    
    @IBInspectable var showErrorBorder: Bool = true  {
        didSet {
            params.showErrorBorder = self.showErrorBorder
        }
    }
    
    var delegate: SFTextFieldDelegate? = nil
    
    // MARK: - Icons attributes
    
    /**
     Icon displayed on Right of the text field when error is not empty
     */
    @IBInspectable var errorIcon: UIImage? {
        didSet {
            params.errorIcon = self.errorIcon
        }
    }
    
    /**
     Image Template rendering mode for error icon
     */
    var errorIconTemplateRenderingMode: Image.TemplateRenderingMode = .template {
        didSet {
            params.errorIconRenderingMode = self.errorIconTemplateRenderingMode
        }
    }
    
    
    // MARK: - Constraints applied
    /**
     Insets applied to the field insets
     */
    var contentInsets: UIEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10) {
        didSet {
            params.contentInsets = self.contentInsets
        }
    }
    
    // MARK: - Views creation
    override var backgroundColor: UIColor? {
        get {
            params.backgroundColor
        }
        set {
            params.backgroundColor = newValue ?? .clear
        }
    }
    
    @IBInspectable var textColor: UIColor = .label {
        didSet {
            params.textColor = self.textColor
        }
    }
    
    @IBInspectable var errorTextColor: UIColor = .red {
        didSet {
            params.errorTextColor = self.errorTextColor
        }
    }
    
    override var tintColor: UIColor! {
        didSet {
            params.tintColor = self.tintColor
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            params.cornerRadius = self.cornerRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            params.borderWidth = self.borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = .clear {
        didSet {
            params.borderColor = self.borderColor
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initializeView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        initializeView()
    }
    
     internal func initializeView() {
        // To be defined in actual class
    }
    
    func registerTextField(withIdentifier name: String, target: SFTextFieldDelegate) {
        self.name = name
        self.delegate = target
    }
}
