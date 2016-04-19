//
//  ContactUsViewController.swift
//  amico
//
//  Created by Yuriy B. on 4/8/16.
//  Copyright © 2016 perpet.io. All rights reserved.
//

import UIKit
import MaterialKit
import MessageUI

final class ContactUsViewController: UIViewController {
    static let storyboardId = "contactUsViewController"

    @IBOutlet private weak var nameTextField: MKTextField?
    @IBOutlet private weak var emailtextField: MKTextField?
    @IBOutlet private weak var messageTextView: AmicoTextView?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

extension ContactUsViewController {
    //MARK:- Action Buttons
    @IBAction func sendFeedbackButtonTapped(sender: UIButton) {
        UIAlertController.showSimpleAlertViewWithText("Feedback Send".localized, title: "Thank you for the feedback! We will process it shortly.".localized, controller: self, completion:nil, alertHandler: { handler in
            self.navigationController?.popViewControllerAnimated(true)
        })
    }

    @IBAction func backButtonTapped(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
}

extension ContactUsViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
}

private extension ContactUsViewController {
    //MARK:- UI Setup
    func setupUI() {
        nameTextField?.layer.borderWidth = 0
        emailtextField?.layer.borderWidth = 0

        //NavBar
        let titleDict: Dictionary<String,AnyObject> = [NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName: UIFont(name: "eurofurence light", size: 26)! ]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict
        self.navigationController?.navigationBar.barTintColor = UIColor.AmicoNavBarGreenColor()
    }
}
