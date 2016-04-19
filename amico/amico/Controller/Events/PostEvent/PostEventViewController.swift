//
//  PostEventViewController.swift
//  amico
//
//  Created by Yuriy B. on 4/15/16.
//  Copyright © 2016 perpet.io. All rights reserved.
//

import UIKit
import MaterialKit

final class PostEventViewController: UIViewController {
    static let storyboardId = "postEventViewController"

    @IBOutlet private weak var titleTextField: MKTextField?
    @IBOutlet private weak var categoryTextField: UITextField?
    @IBOutlet private weak var eventDatePicker: UIDatePicker?
    @IBOutlet private weak var eventTimePicker: UIDatePicker?
    @IBOutlet private weak var detailsTextField: MKTextField?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
}

extension PostEventViewController {
    //MARK:- Action Buttons
    @IBAction func backButtonTapped(sender: UIBarButtonItem) {
    }

    @IBAction func seletCategoryTapped(sender: UIButton) {
    }

    @IBAction func addSoundMessageButtonTapped(sender: AnyObject) {
    }
}

private extension PostEventViewController {
    //MARK:- UI Setup
    func setupUI() {
        detailsTextField?.layer.borderWidth = 0
        titleTextField?.layer.borderWidth = 0
    }
}
