//
//  SignUpViewController.swift
//  amico
//
//  Created by Yuriy B. on 4/5/16.
//  Copyright © 2016 perpet.io. All rights reserved.
//

import UIKit
import MaterialKit

final class SignUpViewController: UIViewController {
    static let sotryboardId = "signUpViewController"

    @IBOutlet private weak var emailTextField: MKTextField?
    @IBOutlet private weak var passwordTextField: MKTextField?
    @IBOutlet private weak var repeatPasswordTextField: MKTextField?
    @IBOutlet private weak var signUpButton: UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

extension SignUpViewController {
    //MARK:- Action buttons
    @IBAction func signUpButtonTapped(sender: UIButton) {
        if !userHasEnteredValidInformation() {
            return
        }

        AmicoAPI.sharedInstance.signUpUser(emailTextField!.text!, password: passwordTextField!.text!) { success, token in
            if success && token?.isEmpty == false {
                guard let createAccountViewController = self.storyboard?.instantiateViewControllerWithIdentifier(CreateAccountViewController.storyboardId) else {
                    return
                }
                self.navigationController?.pushViewController(createAccountViewController, animated: true)
            }
        }
    }
}

private extension SignUpViewController {
    //MARK:- UI setup
    func setupUI() {
        emailTextField?.layer.borderWidth = 0
        passwordTextField?.layer.borderWidth = 0
        repeatPasswordTextField?.layer.borderWidth = 0
        signUpButton?.layer.cornerRadius = (signUpButton?.bounds.height ?? 0) / 2

        let titleDict: Dictionary<String,AnyObject> = [NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName: UIFont(name: "eurofurence light", size: 26)! ]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict
        self.navigationController?.navigationBar.barTintColor = UIColor.AmicoNavBarGreenColor()
        navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.Plain, target:nil, action:nil)
    }

    //MARK:- Helpers
    func userHasEnteredValidInformation() -> Bool {
        guard let email = emailTextField?.text,
            let password = passwordTextField?.text?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()),
            let repeatedPassword = repeatPasswordTextField?.text?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) else {
                UIAlertController.showSimpleAlertViewWithText("Please try to log in again!".localized,
                                                              title: "Ouch".localized,
                                                              controller: self,
                                                              completion: nil,
                                                              alertHandler: nil)
                return false
        }

        if !email.isEmail() {
            UIAlertController.showSimpleAlertViewWithText("Enter a valid email address please.".localized,
                                                          title: "Invalid E-Mail".localized,
                                                          controller: self, completion: nil,
                                                          alertHandler: nil)
            return false
        }

        if password.isEmpty {
            UIAlertController.showSimpleAlertViewWithText("Password must not be empty.".localized,
                                                          title: "Empty Password".localized,
                                                          controller: self,
                                                          completion: nil,
                                                          alertHandler: nil)
            return false
        }

        if password != repeatedPassword {
            UIAlertController.showSimpleAlertViewWithText("Password must match.".localized,
                                                          title: "Password Error".localized,
                                                          controller: self,
                                                          completion: nil,
                                                          alertHandler: nil)
            return false
        }

        return true
    }
}
