//
//  UIAlertControllerExtension.swift
//  amico
//
//  Created by Yuriy B. on 4/8/16.
//  Copyright © 2016 perpet.io. All rights reserved.
//

import UIKit
extension UIAlertController {
    class func showSimpleAlertViewWithText(text: String,
                                           title: String,
                                           controller: UIViewController, completion: (() -> Void)?,
                                           alertHandler: (UIAlertAction -> Void)?) {

        let alert = UIAlertController(title: title, message: text, preferredStyle: .Alert)
        let closeAction = UIAlertAction(title: "Close".localized, style: .Cancel, handler: alertHandler)
        alert.addAction(closeAction)
        controller.presentViewController(alert, animated: true, completion: completion)
    }
}