//
//  SFPasswordField.swift
//  SwiftFormHost
//
//  Created by Loic HACHEME on 04/09/2023.
//

import Foundation
import SwiftUI

class SFPasswordField: SFBaseTextField {
    
    // MARK: - Icons attributes
    
    /**
    Icon left color
     */
    @IBInspectable var iconLeftColor: UIColor = .label {
        didSet {
            params.iconLeftColor = self.iconLeftColor
        }
    }
    
    /**
     Icon displayed on Left of the text field
     */
    @IBInspectable var iconLeft: UIImage? {
        didSet {
            params.iconLeft = self.iconLeft
        }
    }
    
    /**
     Image Template rendering mode for icon left
     */
    var iconLeftTemplateRenderingMode: Image.TemplateRenderingMode = .template {
        didSet {
            params.iconLeftRenderingMode = self.iconLeftTemplateRenderingMode
        }
    }
    
    /**
     Action triggered when user tap on the left icon
     */
    var onClickLeft: (() -> Void)? = nil {
        didSet {
            params.onClickLeft = self.onClickLeft
        }
    }
    
    // MARK: - Password attributes
	
    /**
     Should enable toggle attributes
     */
    var shouldEnableToggleSecureMode: Bool = true {
        didSet {
            params.shouldEnableToggleSecureMode = self.shouldEnableToggleSecureMode
        }
    }
    
	/**
	 The text field's delegate
	 */
	var delegate: SFTextFieldDelegate? = nil
    
    override func initializeView() {
        initPasswordAttributes()
        
        let fieldView = SFPasswordFieldView(params: params)
        let hostingVC = UIHostingController(rootView: fieldView)
        hostingVC.view.translatesAutoresizingMaskIntoConstraints = false
        hostingVC.view.backgroundColor = .clear
        addSubview(hostingVC.view)
        
        NSLayoutConstraint.activate([
            hostingVC.view.topAnchor.constraint(equalTo: topAnchor),
            hostingVC.view.leadingAnchor.constraint(equalTo: leadingAnchor),
            hostingVC.view.trailingAnchor.constraint(equalTo: trailingAnchor),
            hostingVC.view.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func initPasswordAttributes() {
        self.params.isSecuredTextEntry = true
    }
	
	func registerTextField(withIdentifier name: String, target: SFTextFieldDelegate) {
		self.name = name
		self.delegate = target
	}
}


struct SFPasswordFieldView: View {
    @ObservedObject var params: SFTextFieldParams
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 5) {
            HStack(alignment: .center, spacing: 10) {
                if let safeLeftIcon = params.iconLeft {
                    Image(uiImage: safeLeftIcon)
                        .resizable()
                        .renderingMode(params.iconLeftRenderingMode)
                        .foregroundColor(Color(params.iconLeftColor))
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .onTapGesture {
                            if let handlerOnClickLeft = params.onClickLeft {
                                handlerOnClickLeft()
                            }
                        }
                }
                if params.isSecuredTextEntry {
                    SecureField(params.placeholder, text: $params.value)
                        .font(Font(params.font))
						.multilineTextAlignment(params.textAlignment)
                        .accentColor(Color(params.tintColor))
                        .foregroundColor(Color(params.textColor))
                        .keyboardType(params.keyboardType)
                        .frame(maxWidth: .infinity, alignment: .leading)
                } else {
                    TextField(params.placeholder, text: $params.value)
                        .font(Font(params.font))
						.multilineTextAlignment(params.textAlignment)
                        .accentColor(Color(params.tintColor))
                        .foregroundColor(Color(params.textColor))
                        .keyboardType(params.keyboardType)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                if params.shouldEnableToggleSecureMode {
                    Image(uiImage: UIImage(systemName: params.isSecuredTextEntry ? "eye.slash" : "eye")!)
                        .resizable()
                        .renderingMode(params.iconRightRenderingMode)
                        .foregroundColor(Color(params.iconRightColor))
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .onTapGesture {
                            self.params.isSecuredTextEntry.toggle()
                        }
                }
                
            }
            .padding(.leading, params.contentInsets.left)
            .padding(.top, params.contentInsets.top)
            .padding(.trailing, params.contentInsets.right)
            .padding(.bottom, params.contentInsets.bottom)
            .frame(height: params.height)
            .background(Color(params.backgroundColor))
            .cornerRadius(params.cornerRadius)
            .overlay(
                params.borderWidth > 0 ?
                RoundedRectangle(cornerRadius: params.cornerRadius)
                    .stroke(Color(!params.error.isEmpty && params.showErrorBorder ? params.errorTextColor : params.borderColor), lineWidth: params.borderWidth)
                :
                    (
                        !params.error.isEmpty && params.showErrorBorder ?
                        RoundedRectangle(cornerRadius: params.cornerRadius)
                            .stroke(Color(params.errorTextColor), lineWidth: 1)
                        :
                            nil
                    )
            )
        }
        if !params.error.isEmpty && params.showErrorLabel {
            Text(params.error)
                .foregroundColor(Color(params.errorTextColor))
                .font(Font(params.errorFont))
                .frame(maxWidth: .infinity, alignment: params.errorAlignment == .leading ? .leading : (params.errorAlignment == .trailing ? .trailing : .center))
        }
    }
}

struct SFPasswordFieldView_Previews: PreviewProvider {
    static var previews: some View {
        SFPasswordFieldView(params: SFTextFieldParams())
            .previewLayout(.sizeThatFits)
    }
}
