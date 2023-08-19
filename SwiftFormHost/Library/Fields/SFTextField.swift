//
//  SFTextField.swift
//  SwiftFormHost
//
//  Created by ezen on 12/02/2023.
//

import UIKit

@IBDesignable
class SFTextField: UIView {
	
	let textField = UITextField()
	
	let stack = UIStackView()
	
	var error: String = ""
	
	let errorLabel = UILabel()
	
	let errorLabelOffset = Offset(x: 0.0, y: 0.0)
	
	var delegate: SFTextFieldDelegate? = nil
	
	var name: String = ""

	@IBInspectable var value: String {
		get {
			return textField.text ?? ""
		}
		set {
			textField.text = newValue
		}
	}
	
	@IBInspectable var textFieldFont: UIFont {
		get {
			return textField.font ?? UIFont.systemFont(ofSize: 17)
		}
		set {
			textField.font = newValue
		}
	}
	
	@IBInspectable var placeholder: String {
		get {
			return textField.placeholder ?? ""
		}
		set {
			textField.placeholder = newValue
		}
	}
	
	// MARK: - Icons attributes
	/**
	 Icon displayed on Left of the text field
	 */
	@IBInspectable var iconLeft: UIImage? = nil {
		didSet {
			setLeftIcon()
		}
	}
	
	@IBInspectable var iconRight: UIImage? = nil {
		didSet {
			setRightIcon()
		}
	}
	
	/**
	 Action triggered when user tap on the left icon
	 
	 - parameter iconView: Representation of the image view containing the left icon image
	 */
	var onClickLeft: ((UIImageView) -> Void)? = nil
	
	/**
	 Action triggered when user tap on the right icon
	 
	 - parameter iconView: Representation of the image view containing the right icon image
	 */
	var onClickRight: ((UIImageView) -> Void)? = nil
	
	/**
	 Image view holding the left icon
	 */
	private var leftIV = UIImageView()
	
	/**
	 Image view holding the right icon
	 */
	private var rightIV = UIImageView()
	
	// MARK: - Constraints applied
	/**
	 Insets applied to the field insets
	 */
	var contentInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10) {
		didSet {
			updateContentInsets()
		}
	}
	
	/**
	 Padding top
	 */
	private var paddingTop = NSLayoutConstraint()
	
	/**
	 Padding right
	 */
	private var paddingRight = NSLayoutConstraint()
	
	/**
	 Padding bottom
	 */
	private var paddingBottom = NSLayoutConstraint()
	
	/**
	 Padding left
	 */
	private var paddingLeft = NSLayoutConstraint()
	
	/**
	 Horizontal padding
	 */
	@IBInspectable var paddingHorizontal: CGFloat {
		get {
			return min(contentInsets.left, contentInsets.right)
		}
		set {
			contentInsets = UIEdgeInsets(
				top: contentInsets.top,
				left: newValue,
				bottom: contentInsets.bottom,
				right: newValue
			)
		}
	}
	
	/**
	 Vertical padding
	 */
	@IBInspectable var paddingVertical: CGFloat {
		get {
			return min(contentInsets.top, contentInsets.top)
		}
		set {
			contentInsets = UIEdgeInsets(
				top: newValue,
				left: contentInsets.left,
				bottom: newValue,
				right: contentInsets.right
			)
		}
	}
	
	// MARK: - Views creation
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		initializeView()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		
		initializeView()
	}
	
	private func initializeView() {
		stack.axis = .horizontal
		stack.alignment = .fill
		stack.distribution = .fill
		stack.spacing = 10
		stack.translatesAutoresizingMaskIntoConstraints = false
		addSubview(stack)
		
		paddingTop = NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: stack, attribute: .top, multiplier: 1.0, constant: -contentInsets.top)
		paddingRight = NSLayoutConstraint(item: self, attribute: .right, relatedBy: .equal, toItem: stack, attribute: .right, multiplier: 1.0, constant: contentInsets.right)
		paddingBottom = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: stack, attribute: .bottom, multiplier: 1.0, constant: contentInsets.bottom)
		paddingLeft = NSLayoutConstraint(item: self, attribute: .left, relatedBy: .equal, toItem: stack, attribute: .left, multiplier: 1.0, constant: -contentInsets.left)
		NSLayoutConstraint.activate([paddingTop, paddingRight, paddingBottom, paddingLeft])
		
		setLeftIcon()
		setRightIcon()
		
		leftIV.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(leftAction)))
		rightIV.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(rightAction)))
		
		setInputField()
		
		setErrorLabel()
	}
	
	@objc
	func leftAction(_ sender: UITapGestureRecognizer) {
		self.onClickLeft?(self.leftIV)
	}
	
	@objc
	func rightAction(_ sender: UITapGestureRecognizer) {
		self.onClickRight?(self.rightIV)
	}
	
	private func setLeftIcon() {
		if let icon = self.iconLeft {
			if stack.arrangedSubviews.first(where: { $0.tag == 1 }) is UIImageView {
				leftIV.image = icon
			} else {
				leftIV.image = icon
				leftIV.translatesAutoresizingMaskIntoConstraints = false
				leftIV.contentMode = .scaleAspectFit
				leftIV.tintColor = self.tintColor
				leftIV.isUserInteractionEnabled = true
				leftIV.tag = 1
				NSLayoutConstraint.activate([
					NSLayoutConstraint(item: leftIV, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 25)
				])
				stack.insertArrangedSubview(leftIV, at: 0)
			}
		} else {
			if let iconIV = stack.arrangedSubviews.first(where: { $0.tag == 1 }) {
				iconIV.removeFromSuperview()
			}
		}
	}
	
	private func setRightIcon() {
		if let icon = self.iconRight {
			if stack.arrangedSubviews.first(where: { $0.tag == 3 }) is UIImageView {
				rightIV.image = icon
			} else {
				rightIV.image = icon
				rightIV.translatesAutoresizingMaskIntoConstraints = false
				rightIV.contentMode = .scaleAspectFit
				rightIV.tintColor = self.tintColor
				rightIV.isUserInteractionEnabled = true
				rightIV.tag = 3
				NSLayoutConstraint.activate([
					NSLayoutConstraint(item: rightIV, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 25)
				])
				stack.addArrangedSubview(rightIV)
			}
		} else {
			if let iconIV = stack.arrangedSubviews.first(where: { $0.tag == 3 }) {
				iconIV.removeFromSuperview()
			}
		}
	}
	
	private func setInputField() {
		textField.borderStyle = .none
		textField.placeholder = placeholder
		textField.tintColor = self.tintColor
		
		if stack.arrangedSubviews.contains(where: { $0.tag == 2 }) {
			// do customizations
		} else {
			textField.tag = 2
			stack.insertArrangedSubview(textField, at: self.iconLeft != nil ? 1 : 0)
		}
	}
	
	private func setErrorLabel() {
		if self.subviews.contains(where: { $0.tag == 4 }) {
			//
		} else {
			//
		}
	}
	
	private func updateContentInsets() {
		paddingTop.constant = -contentInsets.top
		paddingRight.constant = contentInsets.right
		paddingBottom.constant = contentInsets.bottom
		paddingLeft.constant = -contentInsets.left
	}
	
	func registerTextField(withIdentifier name: String, target: SFTextFieldDelegate) {
		self.name = name
		self.delegate = target
	}
	
//	func textChanged() {
//		if let rules = self.delegate?.fieldsRules() {
//			if let fieldRule = rules[self.name] {
//				// TODO: Apply rule
//			}
//		}
//	}
}
