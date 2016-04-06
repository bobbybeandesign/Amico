

//
//  LoginViewController.swift
//  amico
//
//  Created by Yuriy B. on 4/1/16.
//  Copyright © 2016 perpet.io. All rights reserved.
//

import UIKit
import MaterialKit

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

extension LoginViewController {
    //MARK:- Action Buttons
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
}

extension LoginViewController {
    //MARK:- Action Buttons
    @IBAction func loginButtonTapped(sender: UIButton) {
    }

    @IBAction func forgotPassordButtonTapped(sender: UIButton) {
        guard let forgotPasswordViewController = storyboard?.instantiateViewControllerWithIdentifier(ForgotPasswordViewController.storyboardId) else {
            return
        }
        navigationController?.pushViewController(forgotPasswordViewController, animated: true)
    }
}