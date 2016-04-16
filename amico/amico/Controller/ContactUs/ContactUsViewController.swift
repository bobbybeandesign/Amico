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
        let mailComposer = MFMailComposeViewController()
        mailComposer.mailComposeDelegate = self
        mailComposer.setToRecipients([GlobalConstants.ContactUsViewController.ContactAmicoUrl])
        mailComposer.setSubject("Customer Feedback")
        mailComposer.setMessageBody("User: \(nameTextField?.text ?? "Unknown") /n \(messageTextView?.text ?? "") /n Alternate Contact Email: \(emailtextField?.text ?? "none")", isHTML: false)
        if MFMailComposeViewController.canSendMail() {
            navigationController?.presentViewController(mailComposer, animated: true, completion: nil)
        } else {
            UIAlertController.showSimpleAlertViewWithText("Your device could not send e-mail.  Please check e-mail configuration and try again.".localized,
                                                          title: "Could Not Send Email".localized,
                                                          controller: self,
                                                          completion: nil,
                                                          alertHandler: nil)
        }
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

