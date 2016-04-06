//
//  SignUpViewController.swift
//  amico
//
//  Created by Yuriy B. on 4/1/16.
//  Copyright © 2016 perpet.io. All rights reserved.
//

import UIKit

final class WellcomeViewController: UIViewController {
    static let storybuardId = "wellcomeViewController"

    @IBOutlet private weak var signUpButton: UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBarHidden = true
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBarHidden = false
    }
}

extension WellcomeViewController {
    //MARK:- Action Buttons
    @IBAction func singUpButtonTapped(sender: UIButton) {
        guard let signUpViewController = storyboard?.instantiateViewControllerWithIdentifier(SignUpViewController.sotryboardId) else {
            return
        }

        navigationController?.pushViewController(signUpViewController, animated: true)
    }

    @IBAction func logInButtontapped(sender: UIButton) {
        guard let loginViewController = storyboard?.instantiateViewControllerWithIdentifier(LoginViewController.storyboardId) else {
            return
        }
        navigationController?.pushViewController(loginViewController, animated: true)
    }
}

private extension WellcomeViewController {
    //MARK:- UI Setup
    func setupUI() {
        signUpButton?.layer.borderColor = UIColor.whiteColor().CGColor
        signUpButton?.layer.borderWidth = 1
        signUpButton?.layer.cornerRadius = (signUpButton?.bounds.height ?? 0) / 2
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.Plain, target:nil, action:nil)
    }
}
