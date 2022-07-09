//
//  Signup.swift
//  WizardingSchool-UIKit
//
//  Created by Byeongjo Koo on 2022/07/05.
//

import Foundation

class Signup: NSObject {
    
    var name: String
    @objc dynamic var isValidName: Bool {
        didSet {
            isProceedable = isValidName && isValidRepeat && isValidRepeat
        }
    }
    var password: String {
        didSet {
            let exceedMininumLength = 4 <= password.count
            let containsMoreThanOneLetter = 1 <= password.filter({ $0.isLetter }).count
            let containsMoreThanOneNumber = 1 <= password.filter({ $0.isNumber }).count
            isValidPassword = exceedMininumLength && containsMoreThanOneLetter && containsMoreThanOneNumber
        }
    }
    @objc dynamic var isValidPassword: Bool {
        didSet {
            isProceedable = isValidName && isValidRepeat && isValidRepeat
        }
    }
    var repeatPassword: String {
        didSet {
            isValidRepeat = isValidPassword && (password == repeatPassword)
        }
    }
    @objc dynamic var isValidRepeat: Bool {
        didSet {
            isProceedable = isValidName && isValidRepeat && isValidRepeat
        }
    }
    @objc dynamic var isProceedable: Bool
    
    // MARK: Initializer
    
    override init() {
        name = ""
        isValidName = false
        password = ""
        isValidPassword = false
        repeatPassword = ""
        isValidRepeat = false
        isProceedable = false
        
        super.init()
    }
}
