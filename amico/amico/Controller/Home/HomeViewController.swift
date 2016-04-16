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

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        handleUserLogin()
    }

    @IBAction func logOutButtonTapped(sender: UIButton) {
        AmicoAPI.sharedInstance.logOutUser()
        handleUserLogin()
    }
}

private extension HomeViewController {
    //MARK:- Helpers
    func handleUserLogin() {
        if !AmicoAPI.sharedInstance.userIsLogedIn() {
            let nav = storyboard?.instantiateViewControllerWithIdentifier("123")
            self.navigationController?.presentViewController(nav!, animated: true, completion: nil)
        }
    }
}