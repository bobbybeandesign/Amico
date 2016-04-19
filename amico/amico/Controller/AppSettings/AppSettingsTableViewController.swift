//
//  AppSettingsTableViewController.swift
//  amico
//
//  Created by Yuriy B. on 4/7/16.
//  Copyright © 2016 perpet.io. All rights reserved.
//

import UIKit
import Material
import DLRadioButton

final class AppSettingsTableViewController: UITableViewController {
    static let storyboardId = "appSettingsTableViewController"

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

extension AppSettingsTableViewController {
    //MARK:- Action Buttons
    @IBAction func distanceValueMetricsChanged(sender: DLRadioButton, forEvent event: UIEvent) {
    }

    @IBAction func soundSettingsSwitchValueChanged(sender: MaterialSwitch, forEvent event: UIEvent) {
    }

    @IBAction func deleteOldSwipesButtonTapped(sender: UIButton) {
    }

    @IBAction func signOutButtonTapped(sender: AnyObject) {
        self.navigationController?.popToRootViewControllerAnimated(true)
        AmicoAPI.sharedInstance.logOutUser()
        guard let authenticationnavigationController = storyboard?.instantiateViewControllerWithIdentifier("authenticationnavigationController") else {
            return
        }

        self.navigationController?.presentViewController(authenticationnavigationController, animated: true, completion: nil)
    }

    @IBAction func deleteAccountButtonTapped(sender: UIButton) {
    }

    @IBAction func backButtonTapped(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
}

private extension AppSettingsTableViewController {
    //MARK:- UI Setup
    func setupUI() {
        //NavBar
        let titleDict: Dictionary<String,AnyObject> = [NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName: UIFont(name: "eurofurence light", size: 26)! ]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict
        self.navigationController?.navigationBar.barTintColor = UIColor.AmicoNavBarGreenColor()
    }
}