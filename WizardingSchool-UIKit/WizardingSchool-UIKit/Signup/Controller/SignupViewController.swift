//
//  SignupViewController.swift
//  WizardingSchool-UIKit
//
//  Created by Byeongjo Koo on 2022/07/02.
//

import UIKit

final class SignupViewController: UIViewController {
    
    // MARK: Model(s)
    
    @objc
    private var signup = Signup()
    
    // MARK: Observation(s)
    
    private var validNameObservation: NSKeyValueObservation?
    private var validPasswordObservation: NSKeyValueObservation?
    private var valieRepeatPasswordObservation: NSKeyValueObservation?
    private var createAccountButtonObservation: NSKeyValueObservation?
    
    // MARK: View(s)
    
    @IBOutlet
    private weak var signupView: SignupView!
    
    // MARK: Animation(s)
    
    private var nameValidAnimator: UIViewPropertyAnimator {
        UIViewPropertyAnimator(
            duration: AnimationConstants.validUpdateDuration,
            curve: .linear
        ) { [self] in
            signupView.nameStatusImageView.tintColor = signup.isValidName ? .systemGreen : .systemRed
        }
    }
    private var passwordValidAnimator: UIViewPropertyAnimator {
        UIViewPropertyAnimator(
            duration: AnimationConstants.validUpdateDuration,
            curve: .linear
        ) { [self] in
            signupView.passwordImageView.tintColor = signup.isValidPassword ? .systemGreen : .systemRed
        }
    }
    private var passwordRepeatValidAnimator: UIViewPropertyAnimator {
        UIViewPropertyAnimator(
            duration: AnimationConstants.validUpdateDuration,
            curve: .linear
        ) { [self] in
            signupView.repeatPasswordImageView.tintColor = signup.isValidRepeat ? .systemGreen : .systemRed
        }
    }
    private var proceedableAnimator: UIViewPropertyAnimator {
        UIViewPropertyAnimator(
            duration: AnimationConstants.validUpdateDuration,
            curve: .linear
        ) { [self] in
            signupView.createAccountButton.isEnabled = signup.isProceedable
        }
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupObservations()
    }
    
    // MARK: - Set up observation(s)
    
    private func setupObservations() {
        validNameObservation = observe(\.signup.isValidName, options: [.new]) { [weak self] _, change in
            if let _ = change.newValue {
                DispatchQueue.main.async { [weak self] in
                    self?.nameValidAnimator.startAnimation()
                }
            }
        }
        validPasswordObservation = observe(\.signup.isValidPassword, options: [.new]) { _, change in
            if let _ = change.newValue {
                DispatchQueue.main.async { [weak self] in
                    self?.passwordValidAnimator.startAnimation()
                }
            }
        }
        valieRepeatPasswordObservation = observe(\.signup.isValidRepeat, options: [.new]) { _, change in
            if let _ = change.newValue {
                DispatchQueue.main.async { [weak self] in
                    self?.passwordRepeatValidAnimator.startAnimation()
                }
            }
        }
        createAccountButtonObservation = observe(\.signup.isProceedable, options: [.new]) { _, change in
            if let _ = change.newValue {
                DispatchQueue.main.async { [weak self] in
                    self?.proceedableAnimator.startAnimation()
                }
            }
        }
    }
    
    // MARK: - Server Request for Name Validation (Replacement)
    
    @objc
    private func isValidName() {
        signupView.nameTextField.startLoading()
        DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(1)) { [weak self] in
            let wizards: Set<String> = ["harry", "potter", "hermione", "granger", "ron", "weasley", "severus", "snape"]
            if let name = self?.signup.name.lowercased() {
                self?.signup.isValidName = !name.isEmpty && !wizards.contains(name)
            }
            self?.signupView.nameTextField.stopLoading()
        }
    }
    
    // MARK: - Touches
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        signupView.endEditing(true)
    }
    
    // MARK: - Target Action
    
    @IBAction
    private func textFieldEditingChanged(_ sender: SignupTextField) {
        sender.text = sender.text?.trimmingCharacters(in: .whitespaces)
        if let input = sender.text {
            switch sender.kind {
            case .name:
                signup.isValidName = false
                signup.name = input
                validnameTimer?.invalidate()
                if input.isEmpty == false {
                    startValidNameRequestTimer()
                }
            case .password:
                signup.isValidRepeat = false
                signup.password = input
            case .repeatPassword:
                signup.repeatPassword = input
            case .none: break
            }
        }
    }
    
    // MARK: - Name Validation Timer
    
    private var validnameTimer: Timer?
    
    private func startValidNameRequestTimer() {
        validnameTimer = Timer.scheduledTimer(
            timeInterval: TimeConstants.maximumInputLimit,
            target: self,
            selector: #selector(isValidName),
            userInfo: nil,
            repeats: false
        )
    }
}

// MARK: - Constant(s)

extension SignupViewController {
    
    private enum AnimationConstants {
        
        static let validUpdateDuration: TimeInterval = 0.3
    }
    
    private enum TimeConstants {
        
        static let maximumInputLimit: TimeInterval = 2
    }
}
