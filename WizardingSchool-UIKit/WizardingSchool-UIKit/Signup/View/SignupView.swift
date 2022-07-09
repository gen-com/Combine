//
//  SignupView.swift
//  WizardingSchool-UIKit
//
//  Created by Byeongjo Koo on 2022/07/06.
//

import UIKit

final class SignupView: UIView {
    
    // MARK: - UI Property(ies)
    
    @IBOutlet
    private weak var titleLabel: UILabel! {
        didSet {
            titleLabel.text = Texts.title
            titleLabel.font = .systemFont(ofSize: Texts.titleFontSize)
            titleLabel.textColor = .white
            titleLabel.textAlignment = .center
        }
    }
    
    @IBOutlet
    private(set) weak var nameStatusImageView: UIImageView! {
        didSet {
            nameStatusImageView.tintColor = .white
        }
    }
    @IBOutlet
    private(set) weak var nameTextField: SignupTextField! {
        didSet {
            nameTextField.kind = .name
            nameTextField.setAttributedPlaceholder(kind: .name)
            nameTextField.keyboardType = .namePhonePad
        }
    }
    
    @IBOutlet
    private(set) weak var passwordImageView: UIImageView! {
        didSet {
            nameStatusImageView.tintColor = .white
        }
    }
    @IBOutlet
    private(set) weak var passwordTextField: SignupTextField! {
        didSet {
            passwordTextField.kind = .password
            passwordTextField.setAttributedPlaceholder(kind: .password)
            passwordTextField.isSecureTextEntry = true
        }
    }
    
    @IBOutlet
    private(set) weak var repeatPasswordImageView: UIImageView! {
        didSet {
            nameStatusImageView.tintColor = .white
        }
    }
    @IBOutlet
    private(set) weak var repeatPasswordTextField: SignupTextField! {
        didSet {
            repeatPasswordTextField.kind = .repeatPassword
            repeatPasswordTextField.setAttributedPlaceholder(kind: .repeatPassword)
            repeatPasswordTextField.isSecureTextEntry = true
        }
    }
    
    @IBOutlet
    private(set) weak var createAccountButton: SignupButton! {
        didSet {
            createAccountButton.isEnabled = false
        }
    }
    
    // MARK: - Initializer(s)

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        viewCongiguration()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        viewCongiguration()
    }
    
    // MARK: - Configuration
    
    private func viewCongiguration() {
        backgroundColor = .black
    }
}

// MARK: - Constant(s)

extension SignupView {
    
    private enum Texts {
        
        static let title = "Wizarding School Signup"
        static let titleFontSize: CGFloat = 25
    }
}
