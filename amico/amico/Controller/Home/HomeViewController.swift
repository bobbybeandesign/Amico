//
//  HomeViewController.swift
//  amico
//
//  Created by Yuriy B. on 4/5/16.
//  Copyright © 2016 perpet.io. All rights reserved.
//

import UIKit

final class HomeViewController: UIViewController {
    static let storyboardId = "homeViewController"

    override func viewDidLoad() {
        super.viewDidLoad()

        //NavBar
        let titleDict: Dictionary<String,AnyObject> = [NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName: UIFont(name: "eurofurence light", size: 26)! ]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict
        self.navigationController?.navigationBar.barTintColor = UIColor.AmicoNavBarGreenColor()
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        handleUserLogin()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.sideNavigationController?.enabled = true
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.sideNavigationController?.enabled = false
        self.navigationController?.sideNavigationController
    }
}

private extension HomeViewController {
    //MARK:- Helpers
    func handleUserLogin() {
        if !AmicoAPI.sharedInstance.userIsLogedIn() {
            guard let authenticationnavigationController = storyboard?.instantiateViewControllerWithIdentifier("authenticationnavigationController") else {
                return
            }

            self.navigationController?.presentViewController(authenticationnavigationController, animated: true, completion: nil)
        }
    }
}
