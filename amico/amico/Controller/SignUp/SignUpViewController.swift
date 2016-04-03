//
//  SignUpViewController.swift
//  amico
//
//  Created by Yuriy B. on 4/1/16.
//  Copyright © 2016 perpet.io. All rights reserved.
//

import UIKit

final class SignUpViewController: UIViewController {
    static let storybuardId = "signUpViewController"

    @IBOutlet private weak var signUpButton: UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
}

extension SignUpViewController {
    //MARK:- Action Buttons
    @IBAction func singUpButtonTapped(sender: UIButton) {
    }

    @IBAction func logInButtontapped(sender: UIButton) {
    }
}

private extension SignUpViewController {
    //MARK:- UI Setup
    func setupUI() {
        signUpButton?.layer.borderColor = UIColor.whiteColor().CGColor
        signUpButton?.layer.borderWidth = 1
        signUpButton?.layer.cornerRadius = (signUpButton?.bounds.height ?? 0) / 2
    }
}