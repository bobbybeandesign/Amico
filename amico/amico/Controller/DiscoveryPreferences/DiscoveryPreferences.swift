//
//  DiscoveryPreferences.swift
//  amico
//
//  Created by Yuriy B. on 4/11/16.
//  Copyright © 2016 perpet.io. All rights reserved.
//

import UIKit
import Material
import TTRangeSlider
import ActionSheetPicker_3_0
import TagListView

final class DiscoveryPreferencesTableViewController: UITableViewController {
    static let storyboardId = "discoveryPreferencesTableViewController"

    @IBOutlet private weak var accountVisibilitySwitch: MaterialSwitch?
    @IBOutlet private weak var showManSwitch: MaterialSwitch?
    @IBOutlet private weak var showWomenSwitch: NSLayoutConstraint?
    @IBOutlet private weak var searchDistanceLabel: UILabel?
    @IBOutlet private weak var agerangeLabel: UILabel?
    @IBOutlet private weak var searchDistanceSlider: TTRangeSlider?
    @IBOutlet private weak var ageRangeSlider: TTRangeSlider?
    @IBOutlet private weak var tagListView: TagListView?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
}

extension DiscoveryPreferencesTableViewController {
    //MARK:- Action Buttons
    @IBAction func roamAbroadButtonTapped(sender: UIButton) {
    }

    @IBAction func backButtonTapped(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }

    @IBAction func employmentButtonTapped(sender: UIButton) {
        let actionSheetPicker = ActionSheetStringPicker(title: "Employment".localized, rows: GlobalConstants.ProfileInformation.Education, initialSelection: 0, doneBlock: { (picker, index, selectedObject) in

            }, cancelBlock: { picker in

            }, origin: sender.superview!.superview)
        actionSheetPicker.showActionSheetPicker()
    }

    @IBAction func educationButtonTapped(sender: UIButton) {
        let actionSheetPicker = ActionSheetStringPicker(title: "Education".localized, rows: GlobalConstants.ProfileInformation.Education, initialSelection: 0, doneBlock: { (picker, index, selectedObject) in

            }, cancelBlock: { picker in

            }, origin: sender.superview!.superview)
        actionSheetPicker.showActionSheetPicker()
    }

    @IBAction func interestsButtonTapped(sender: UIButton) {
        let actionSheetPicker = ActionSheetStringPicker(title: "Education".localized, rows: GlobalConstants.ProfileInformation.Interests, initialSelection: 0, doneBlock: { (picker, index, selectedObject) in

            }, cancelBlock: { picker in

            }, origin: sender.superview!.superview)
        actionSheetPicker.showActionSheetPicker()
    }
}

private extension DiscoveryPreferencesTableViewController {
    //MARK:- UI Setup
    func setupUI() {
        //Taglist
        tagListView?.textFont = UIFont(name:"eurofurence light", size: 14)!
        tagListView?.alignment = .Center
        tagListView?.addTag("Test")
//        //NavBar
        let titleDict: Dictionary<String,AnyObject> = [NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName: UIFont(name: "eurofurence light", size: 26)! ]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict
        self.navigationController?.navigationBar.barTintColor = UIColor.AmicoNavBarGreenColor()
    }
}