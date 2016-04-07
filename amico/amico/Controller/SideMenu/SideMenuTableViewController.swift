//
//  SideMenuTableViewController.swift
//  amico
//
//  Created by Yuriy B. on 4/6/16.
//  Copyright © 2016 perpet.io. All rights reserved.
//

import UIKit

enum LeftMenuItem: String {
    case Discovery = "Discovery Preferences"
    case Swipe = "Swipe"
    case VoiceFeed = "Voice Feed"
    case Matches = "Matches"
    case Events = "Events"
    case PopUpVoice = "Pop up Voice"
    case AppSettings = "App Settings"
    case ContactUs = "Contact Us"

    var image: UIImage? {
        switch self {
        case .Discovery:
            return UIImage(named: "dicovery")
        case .Swipe:
            return UIImage(named: "swipe")
        case .VoiceFeed:
            return UIImage(named: "mic")
        case .Matches:
            return UIImage(named: "matches")
        case .Events:
            return UIImage(named: "message")
        case .PopUpVoice:
            return UIImage(named: "popupVoice")
        case .AppSettings:
            return UIImage(named: "settings")
        case .ContactUs:
            return UIImage(named: "message")
        }
    }
}

enum LeftMenuType: Int {
    case TopMenu = 0
    case BottomMenu = 1
}

final class SideMenuTableViewController: UITableViewController {
    static let storyboardId = "sideMenuTableViewController"

    private let primaryMenuDatasource = [
        LeftMenuItem.Discovery,
        LeftMenuItem.Swipe,
        LeftMenuItem.VoiceFeed,
        LeftMenuItem.Matches,
        LeftMenuItem.Events,
        LeftMenuItem.PopUpVoice,
    ]
    private let secondaryMenuDatasource = [
        LeftMenuItem.AppSettings,
        LeftMenuItem.ContactUs,
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.registerNib(SideMenuTableViewCell.nib, forCellReuseIdentifier: SideMenuTableViewCell.reuseIdentifier)
    }
}

extension SideMenuTableViewController {
    //MARK:- UITableViewDataSource
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case LeftMenuType.TopMenu.rawValue:
            return primaryMenuDatasource.count
        default:
            return secondaryMenuDatasource.count
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case LeftMenuType.TopMenu.rawValue:
            return cellForMenu(tableView, indexPath: indexPath, dataSource: primaryMenuDatasource)

        case LeftMenuType.BottomMenu.rawValue:
            return cellForMenu(tableView, indexPath: indexPath, dataSource: secondaryMenuDatasource)

        default:
            return UITableViewCell()
        }
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case LeftMenuType.TopMenu.rawValue:
            return SideMenuHeaderView.instanceFromNib()
        case LeftMenuType.BottomMenu.rawValue:
            return SideMenuSeparatorHeader.instanceFromNib()
        default:
            return UIView()
        }
    }

    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case LeftMenuType.TopMenu.rawValue:
            return 100
        case LeftMenuType.BottomMenu.rawValue:
            return 35
        default:
            return 30
        }
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
}

private extension SideMenuTableViewController {
    //MARK:- Helpers
    func cellForMenu(tableView: UITableView, indexPath: NSIndexPath, dataSource: Array<LeftMenuItem>) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellWithIdentifier(SideMenuTableViewCell.reuseIdentifier) as? SideMenuTableViewCell else {
            return UITableViewCell()
        }
        cell.cellType = dataSource[indexPath.row]
        return cell
    }
}
