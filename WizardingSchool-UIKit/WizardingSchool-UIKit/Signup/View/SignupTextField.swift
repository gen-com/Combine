//
//  SignupTextField.swift
//  WizardingSchool-UIKit
//
//  Created by Byeongjo Koo on 2022/07/03.
//

import UIKit

class SignupTextField: UITextField {
    
    // MARK: - Kind
    
    enum Kind {
        
        case none
        case name
        case password
        case repeatPassword
    }
    
    // MARK: - Property(ies)
    
    var kind: Kind = .none
    
    // MARK: UI
    
    private var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .white
        
        return activityIndicator
    }()
    
    // MARK: - Initializer(s)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        textFieldConfiguration()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        textFieldConfiguration()
    }
    
    // MARK: - Draw
    
    override func draw(_ rect: CGRect) {
        let borderRect = CGRect(
            x: rect.origin.x + DrawingConstants.borderLineWidth,
            y: rect.origin.y + DrawingConstants.borderLineWidth,
            width: rect.width - (DrawingConstants.borderLineWidth * 2),
            height: rect.height - (DrawingConstants.borderLineWidth * 2)
        )
        let path = UIBezierPath(roundedRect: borderRect, cornerRadius: DrawingConstants.borderCornerRaidus)
        path.lineWidth = DrawingConstants.borderLineWidth
        DrawingConstants.borderColor.set()
        path.stroke()
    }
    
    // MARK: - Configuration
    
    private func textFieldConfiguration() {
        textColor = .white
        font = .systemFont(ofSize: Tests.fontSize)
        adjustsFontSizeToFitWidth = true
        borderStyle = .none
        rightView = activityIndicatorView
        rightViewMode = .always
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        CGRect(
            x: MetricConstants.textRectOriginX,
            y: bounds.origin.y,
            width: bounds.width - (MetricConstants.textRectOriginX * 2),
            height: bounds.height
        )
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        CGRect(
            x: MetricConstants.textRectOriginX,
            y: bounds.origin.y,
            width: bounds.width - (MetricConstants.textRectOriginX * 2),
            height: bounds.height
        )
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        let loadingViewWidth = bounds.maxY - MetricConstants.loadingViewOriginY * 2
        let rect = CGRect(
            x: bounds.maxX - loadingViewWidth - MetricConstants.textRectOriginX,
            y: MetricConstants.loadingViewOriginY,
            width: loadingViewWidth,
            height: loadingViewWidth
        )
        
        return rect
    }
    
    func setAttributedPlaceholder(kind: Placeholder) {
        attributedPlaceholder = NSAttributedString(
            string: kind.rawValue,
            attributes: [
                .foregroundColor: Tests.placeholderColor,
                .font: UIFont.systemFont(ofSize: Tests.fontSize)
            ]
        )
    }
    
    // MARK: - Loading
    
    func startLoading() {
        if activityIndicatorView.isAnimating == false {
            DispatchQueue.main.async(qos: .userInteractive) { [weak self] in
                self?.activityIndicatorView.startAnimating()
            }
        }
    }
    
    func stopLoading() {
        DispatchQueue.main.async(qos: .userInteractive) { [weak self] in
            self?.activityIndicatorView.stopAnimating()
        }
    }
}

// MARK: - Constant(s)

extension SignupTextField {
    
    private enum DrawingConstants {
        
        static let borderLineWidth: CGFloat = 1
        static let borderColor: UIColor = .darkGray
        static let borderCornerRaidus: CGFloat = 5
    }
    
    private enum MetricConstants {
        
        static let textRectOriginX: CGFloat = 5
        static let loadingViewOriginY: CGFloat = 2
    }
    
    private enum Tests {
        
        static let placeholderColor = UIColor.darkGray
        static let fontSize: CGFloat = 18
    }
    
    enum Placeholder: String {
        
        case name = "Wizard name"
        case password = "Password"
        case repeatPassword = "Repeat password"
    }
}
