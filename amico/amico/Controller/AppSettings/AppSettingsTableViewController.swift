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
    }

    @IBAction func deleteAccountButtonTapped(sender: UIButton) {
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