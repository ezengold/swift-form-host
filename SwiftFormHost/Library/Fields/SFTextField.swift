//
//  SFTextField.swift
//  SwiftFormHost
//
//  Created by ezen on 12/02/2023.
//

import UIKit
import SwiftUI

// @IBDesignable
class SFTextField: SFBaseTextField {
	
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
    Icon right color
     */
    @IBInspectable var iconRightColor: UIColor = .label {
        didSet {
            params.iconRightColor = self.iconRightColor
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
	 Icon displayed on Right of the text field
	 */
	@IBInspectable var iconRight: UIImage? {
		didSet {
			params.iconRight = self.iconRight
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
     Image Template rendering mode for icon right
     */
    var iconRightTemplateRenderingMode: Image.TemplateRenderingMode = .template {
        didSet {
            params.iconRightRenderingMode = self.iconRightTemplateRenderingMode
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
	
	/**
	 Action triggered when user tap on the right icon
	 */
	var onClickRight: (() -> Void)? = nil {
		didSet {
			params.onClickRight = self.onClickRight
		}
	}
	
	override func initializeView() {
		let fieldView = SFTextFieldView(params: params)
        
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
}

struct SFTextFieldView: View {
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
				TextField(params.placeholder, text: $params.value)
					.font(Font(params.font))
					.accentColor(Color(params.tintColor))
					.foregroundColor(Color(params.textColor))
					.keyboardType(params.keyboardType)
					.multilineTextAlignment(params.textAlignment)
					.frame(maxWidth: .infinity, alignment: .leading)
				if let safeErrorIcon = params.errorIcon, !params.error.isEmpty {
					Image(uiImage: safeErrorIcon)
						.resizable()
						.renderingMode(params.errorIconRenderingMode)
						.foregroundColor(Color(params.errorTextColor))
						.scaledToFit()
						.frame(width: 20, height: 20)
						.onTapGesture {
							if let handlerOnClickRight = params.onClickRight {
								handlerOnClickRight()
							}
						}
				} else {
					if let safeRightIcon = params.iconRight {
						Image(uiImage: safeRightIcon)
							.resizable()
							.renderingMode(params.iconRightRenderingMode)
							.foregroundColor(Color(params.iconRightColor))
							.scaledToFit()
							.frame(width: 20, height: 20)
							.onTapGesture {
								if let handlerOnClickRight = params.onClickRight {
									handlerOnClickRight()
								}
							}
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

struct SFTextFieldView_Previews: PreviewProvider {
	static var previews: some View {
		SFTextFieldView(params: SFTextFieldParams())
			.previewLayout(.sizeThatFits)
	}
}
