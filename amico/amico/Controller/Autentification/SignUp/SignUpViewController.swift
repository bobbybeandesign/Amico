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
        //TODO: Functionality pending
        guard let createAccountViewController = storyboard?.instantiateViewControllerWithIdentifier(CreateAccountViewController.storyboardId) else {
            return
        }
        navigationController?.pushViewController(createAccountViewController, animated: true)
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
}
