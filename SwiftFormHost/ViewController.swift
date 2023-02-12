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
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		createViews()
	}
}

extension ViewController {
	
	private func createViews() {
		emailField.delegate = self
		nameField.delegate = self
		passwordField.delegate = self
		passconfField.delegate = self
	}
}

extension ViewController: SFTextFieldDelegate {
	//
}
