//
//  SignupButton.swift
//  WizardingSchool-UIKit
//
//  Created by Byeongjo Koo on 2022/07/06.
//

import UIKit

final class SignupButton: UIButton {
    
    // MARK: - Initializer(s)

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        buttonConfiguration()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        buttonConfiguration()
    }
    
    // MARK: - Configuration
    
    private func buttonConfiguration() {
        setAttributedTitle(
            NSAttributedString(
                string: Texts.title,
                attributes: [
                    .font: UIFont.boldSystemFont(ofSize: Texts.titleFontSize),
                    .foregroundColor: UIColor.white
                ]
            ),
            for: .normal
        )
        backgroundColor = .systemGreen
        layer.cornerRadius = DrawingConstants.cornerRadius
        clipsToBounds = true
    }
    
    override var isEnabled: Bool {
        didSet {
            backgroundColor = isEnabled ? .systemGreen : .gray
        }
    }
}

// MARK: - Constant(s)

extension SignupButton {
    
    private enum Texts {
        
        static let title = "Create Account"
        static let titleFontSize: CGFloat = 18
    }
    
    private enum DrawingConstants {
        
        static let cornerRadius: CGFloat = 10
    }
}
