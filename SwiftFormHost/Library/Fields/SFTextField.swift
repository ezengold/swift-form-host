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
	
	// constraints
	private var paddingTop = NSLayoutConstraint()
	private var paddingRight = NSLayoutConstraint()
	private var paddingBottom = NSLayoutConstraint()
	private var paddingLeft = NSLayoutConstraint()
	
	var contentInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10) {
		didSet {
			updateContentInsets()
		}
	}
	
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
		
		setLeftIcon(self.iconLeft)
		setRightIcon(self.iconRight)
		
		setInputField()
		
		setErrorLabel()
	}
	
	func setLeftIcon(_ iconImg: UIImage? = nil, onClick: (() -> Void)? = nil) {
		if let icon = self.iconLeft {
			if let leftIconIV = stack.arrangedSubviews.first(where: { $0.tag == 1 }) as? UIImageView {
				leftIconIV.image = icon
			} else {
				let leftIconIV = UIImageView(image: icon)
				leftIconIV.translatesAutoresizingMaskIntoConstraints = false
				leftIconIV.contentMode = .scaleAspectFit
				leftIconIV.tintColor = self.tintColor
				leftIconIV.tag = 1
				NSLayoutConstraint.activate([
					NSLayoutConstraint(item: leftIconIV, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 25)
				])
				stack.insertArrangedSubview(leftIconIV, at: 0)
			}
		} else {
			if let iconIV = stack.arrangedSubviews.first(where: { $0.tag == 1 }) {
				iconIV.removeFromSuperview()
			}
		}
	}
	
	func setRightIcon(_ iconImg: UIImage? = nil, onClick: (() -> Void)? = nil) {
		if let icon = self.iconRight {
			if let rightIconIV = stack.arrangedSubviews.first(where: { $0.tag == 3 }) as? UIImageView {
				rightIconIV.image = icon
			} else {
				let rightIconIV = UIImageView(image: icon)
				rightIconIV.translatesAutoresizingMaskIntoConstraints = false
				rightIconIV.contentMode = .scaleAspectFit
				rightIconIV.tintColor = self.tintColor
				rightIconIV.tag = 3
				NSLayoutConstraint.activate([
					NSLayoutConstraint(item: rightIconIV, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 25)
				])
				stack.addArrangedSubview(rightIconIV)
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
	
	func textChanged() {
		if let rules = self.delegate?.fieldsRules() {
			if let fieldRule = rules[self.name] {
				// TODO: Apply rule
			}
		}
	}
}
