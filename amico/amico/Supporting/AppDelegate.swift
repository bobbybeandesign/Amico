//
//  AppDelegate.swift
//  amico
//
//  Created by Yuriy Berdnikov on 3/31/16.
//  Copyright © 2016 perpet.io. All rights reserved.
//

import UIKit
import Material

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        let homeViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("homeViewControllerNav")
        let sideMenuViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier(SideMenuTableViewController.storyboardId)

        let rootVC = SideNavigationController(rootViewController: homeViewController, leftViewController: sideMenuViewController)
        rootVC.setLeftViewWidth(300, hidden: true, animated: true)
        window?.rootViewController = rootVC

        return true
    }
}

