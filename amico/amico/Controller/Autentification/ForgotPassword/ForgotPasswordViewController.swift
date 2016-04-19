//
//  ForgotPasswordViewController.swift
//  amico
//
//  Created by Yuriy B. on 4/5/16.
//  Copyright © 2016 perpet.io. All rights reserved.
//

import UIKit
import MaterialKit

final class ForgotPasswordViewController: UIViewController {
    static let storyboardId = "forgotPasswordViewController"

    @IBOutlet private weak var emailTextField: MKTextField?
    @IBOutlet private weak var resetPasswordButton: UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

extension ForgotPasswordViewController {
    //MARK: Setup UI
    func setupUI() {
        resetPasswordButton?.layer.cornerRadius = (resetPasswordButton?.bounds.height ?? 0) / 2
        emailTextField?.layer.borderWidth = 0

        let titleDict: Dictionary<String,AnyObject> = [NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName: UIFont(name: "eurofurence light", size: 26)! ]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict
        self.navigationController?.navigationBar.barTintColor = UIColor.AmicoNavBarGreenColor()
    }
}

extension ForgotPasswordViewController {
    //MARK: Action Buttons
    @IBAction func resetPasswordTapped(sender: UIButton) {
        //TODO:- Replace when API is ready.
        UIAlertController.showSimpleAlertViewWithText("You will shortly receive instructions on how to reset your password by E-Mail".localized, title: "Done".localized, controller: self, completion: nil, alertHandler: nil)
    }
}
