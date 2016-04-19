//
//  LoginViewController.swift
//  amico
//
//  Created by Yuriy B. on 4/1/16.
//  Copyright © 2016 perpet.io. All rights reserved.
//

import UIKit
import MaterialKit
import SVProgressHUD

class LoginViewController: UIViewController, UITextFieldDelegate {
    static let storyboardId = "loginViewController"

    @IBOutlet private weak var emailTextField: MKTextField?
    @IBOutlet private weak var passwordTextField: MKTextField?
    @IBOutlet private weak var loginButton: UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

private extension LoginViewController {
    //MARK:- UI Setup
    func setupUI() {
        emailTextField?.layer.borderWidth = 0
        passwordTextField?.layer.borderWidth = 0
        loginButton?.layer.cornerRadius = (loginButton?.bounds.height ?? 0) / 2

        let titleDict: Dictionary<String,AnyObject> = [NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName: UIFont(name: "eurofurence light", size: 26)! ]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict
        self.navigationController?.navigationBar.barTintColor = UIColor.AmicoNavBarGreenColor()
        navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.Plain, target:nil, action:nil)
    }

    //MARK:- Helpers
    func userHasEnteredValidInformation() -> Bool {
        guard let email = emailTextField?.text,
            let password = passwordTextField?.text?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) else {
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

        return true
    }
}

extension LoginViewController {
    //MARK:- Action Buttons
    @IBAction func loginButtonTapped(sender: UIButton) {
        SVProgressHUD.show()
        if !userHasEnteredValidInformation() {
            SVProgressHUD.dismiss()
            return
        }

        AmicoAPI.sharedInstance.signInUser(emailTextField!.text!, password: passwordTextField!.text!) { success, token in
            if success && token?.isEmpty == false {
                self.dismissViewControllerAnimated(true, completion: nil)
            } else {
                UIAlertController.showSimpleAlertViewWithText("Please make sure to enter the right credentials.".localized,
                                                              title: "Could not Login!".localized,
                                                              controller: self,
                                                              completion: nil,
                                                              alertHandler: nil)
            }
            SVProgressHUD.dismiss()

        }
    }

    @IBAction func forgotPassordButtonTapped(sender: UIButton) {
        guard let forgotPasswordViewController = storyboard?.instantiateViewControllerWithIdentifier(ForgotPasswordViewController.storyboardId) else {
            return
        }
        navigationController?.pushViewController(forgotPasswordViewController, animated: true)
    }
}