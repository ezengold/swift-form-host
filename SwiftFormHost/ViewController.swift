//
//  ViewController.swift
//  SwiftFormHost
//
//  Created by ezen on 12/02/2023.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var emailField: SFTextField!
	
	@IBOutlet weak var nameField: SFTextField!
	
	@IBOutlet weak var passwordField: SFTextField!
	
	@IBOutlet weak var passconfField: SFTextField!
	
	var rules = [String: [String]]()
	
	var isSecured: Bool = true
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		createViews()
	}
}

extension ViewController {
	
	private func createViews() {
		nameField.registerTextField(withIdentifier: nameField.tag.description, target: self)
		
		emailField.registerTextField(withIdentifier: emailField.tag.description, target: self)
		emailField.error = "lorem ipsum dolor sit"
		
		passwordField.registerTextField(withIdentifier: passwordField.tag.description, target: self)
		passconfField.registerTextField(withIdentifier: passconfField.tag.description, target: self)
	}
	
//	func submit() {
//		// pass the fields data and rules defined
//		let validation = SwiftFormHost.shared.validateForm(data: [
//			emailField.tag.description: emailField.text,
//
//		], rules: self.rules))
//
//		if validation.isFormValid {
//			//
//		}
//	}
}

extension ViewController: SFTextFieldDelegate {
	
	func fieldsRules() -> [String: [String]] {
		self.rules
	}
}
