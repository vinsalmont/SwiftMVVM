//
//  AppController.swift
//  swiftMVVM
//
//  Created by Vinícius Salmont
//  Copyright © 2022 Salmont Dev. All rights reserved.
//

import UIKit

class AppController: UIViewController {
    private var tap = UITapGestureRecognizer()
    private var heightConstraint: NSLayoutConstraint?
    
    var keyboardWillShowBlock:((_ keyboardHeight: CGFloat) -> Void)?
    var keyboardWillHideBlock:((_ keyboardHeight: CGFloat) -> Void)?


    public init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillBeHidden),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    override public func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboardWillShow(_ notification: NSNotification) {
        guard UIApplication.shared.applicationState == .active else { return }
        
        tap = UITapGestureRecognizer(target: self, action: #selector(stopEditing))
        tap.cancelsTouchesInView = false
        
        self.view.addGestureRecognizer(tap)
        adaptControlsAccording(to: notification, isMovingUp: true)
    }
    
    @objc func keyboardWillBeHidden(_ notification: NSNotification) {
        guard UIApplication.shared.applicationState == .active else { return }
        
        view.removeGestureRecognizer(tap)
        adaptControlsAccording(to: notification, isMovingUp: false)
    }
    
    // TextField management
    @objc func stopEditing() {
        view.endEditing(true)
        view.removeGestureRecognizer(tap)
    }

}

// MARK: - Keyboard animation methods
extension AppController {

    func addKeyboardListeners() {
        keyboardWillShowBlock = { height in
            let safeAreaInset = self.view.safeAreaInsets.bottom
            
            let newHeight = self.view.frame.size.height - (height == 0 ? 216 : height) + safeAreaInset
            
            if self.heightConstraint == nil {
                self.heightConstraint = NSLayoutConstraint(item: self.view!,
                                                           attribute: .height,
                                                           relatedBy: .equal,
                                                           toItem: nil,
                                                           attribute: .notAnAttribute,
                                                           multiplier: 1.0,
                                                           constant: newHeight)
            } else {
                self.heightConstraint?.constant = newHeight
            }
            
            NSLayoutConstraint.activate([self.heightConstraint!])
        }
        
        keyboardWillHideBlock = { height in
            let newHeight = UIScreen.main.bounds.size.height - self.view.frame.origin.y
            
            if self.heightConstraint == nil {
                self.heightConstraint = NSLayoutConstraint(item: self.view!,
                                                           attribute: .height,
                                                           relatedBy: .equal,
                                                           toItem: nil,
                                                           attribute: .notAnAttribute,
                                                           multiplier: 1.0,
                                                           constant: newHeight)
            } else {
                self.heightConstraint?.constant = newHeight
            }
            
            NSLayoutConstraint.activate([self.heightConstraint!])
        }
    }
    
    func adaptControlsAccording(to notification: NSNotification, isMovingUp: Bool) {
        let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey]
        let keyboardSizeValue = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        
        if let durationValue = (duration as? NSNumber)?.doubleValue, let height = keyboardSizeValue?.height {
            self.animate(isMovingUp, durationValue, height)
        }
        
    }
    
    func animate(_ isMovingUp: Bool, _ duration: TimeInterval, _ keyboardHeight: CGFloat) {
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseInOut, animations: {
            if isMovingUp {
                self.keyboardWillShowBlock?(keyboardHeight)
            } else {
                self.keyboardWillHideBlock?(keyboardHeight)
            }
            
            self.view.layoutIfNeeded()
        })
    }
}

// MARK: - UIAlertController methods
extension AppController {
    func present(error: Error) {
        DispatchQueue.main.async {
            self.present(title: "Oops", message: error.localizedDescription)
        }
    }
    
    func present(title: String, message: String, customAction: UIAlertAction? = nil, handler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: handler))
        if let customAction = customAction {
            alert.addAction(customAction)
        }
        
        present(alert, animated: true)
    }
}
