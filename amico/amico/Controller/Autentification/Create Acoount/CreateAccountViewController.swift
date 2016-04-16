//
//  File.swift
//  amico
//
//  Created by Yuriy B. on 4/4/16.
//  Copyright © 2016 perpet.io. All rights reserved.
//

import UIKit
import MaterialKit
import DLRadioButton

final class CreateAccountViewController: UIViewController {
    static let storyboardId = "createAccountViewController"

    @IBOutlet private weak var userPictureButton: UIButton?
    @IBOutlet private weak var nameTextField: MKTextField?
    @IBOutlet private weak var surnameTextField: MKTextField?
    @IBOutlet private weak var createAccountButton: UIButton?
    @IBOutlet private weak var datePicker: UIDatePicker?
    @IBOutlet private weak var maleRadioButton: DLRadioButton?
    @IBOutlet private weak var femaleRadioButton: DLRadioButton?

    private var imagePicker = UIImagePickerController()
    private var gender: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

private extension CreateAccountViewController {
    //MARK:- UI Setup
    func setupUI() {
        //buttons
        createAccountButton?.layer.cornerRadius = (createAccountButton?.bounds.height ?? 0) / 2
        userPictureButton?.layer.cornerRadius = (userPictureButton?.bounds.height ?? 0) / 2

        //textfileds
        nameTextField?.layer.borderWidth = 0
        surnameTextField?.layer.borderWidth = 0

        //NavBar
        let titleDict: Dictionary<String,AnyObject> = [NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName: UIFont(name: "eurofurence light", size: 26)! ]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict
        self.navigationController?.navigationBar.barTintColor = UIColor.AmicoNavBarGreenColor()
    }
}

extension CreateAccountViewController {
    //MARK:- Action Buttons
    @IBAction func userPictureButtonTapped(sender: AnyObject) {
        let alert = UIAlertController(title: "Pick Source".localized, message: "Chose between a library and Camera".localized, preferredStyle: .Alert)
        let cameraAction = UIAlertAction(title: "Camera".localized, style: .Default) { alertAction in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
                self.imagePicker.delegate = self
                self.imagePicker.sourceType = UIImagePickerControllerSourceType.Camera;
                self.imagePicker.allowsEditing = true
                self.presentViewController(self.imagePicker, animated: true, completion: nil)
            }
        }

        let libaryAction = UIAlertAction(title: "Library".localized, style: .Default) { alertAction in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
                self.imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary;
                self.imagePicker.allowsEditing = true
                self.imagePicker.delegate = self
                self.presentViewController(self.imagePicker, animated: true, completion: nil)
            }
        }

        let cancelAction = UIAlertAction(title: "Cancel".localized, style: .Cancel, handler: nil)
        alert.addAction(cameraAction)
        alert.addAction(libaryAction)
        alert.addAction(cancelAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }

    @IBAction func createAccountButtonTapped(sender: UIButton) {
        if !userHasProvidedEnoughInformation() {
            return
        }
        let formater = NSDateFormatter()
        formater.dateFormat = "YYYY-MM-DD"
        let date = formater.stringFromDate(datePicker!.date)
        AmicoAPI.sharedInstance.editUserProfile(gender, about: nil, employments: nil, educations: nil, interests: nil, birthDay: date) { success, token in
            if success && token?.isEmpty == false {
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }
    }

    @IBAction func genderSelectedButtonTapped(sender: DLRadioButton) {
        gender = sender == maleRadioButton ? "m" : "f"
    }
}

extension CreateAccountViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //MARK:- UIImagePickerControllerDelegate
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        userPictureButton?.setImage(image, forState: .Normal)
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
}

private extension CreateAccountViewController {
    //MARK: Helpers
    func userHasProvidedEnoughInformation() -> Bool {
        guard let name = nameTextField?.text,
              let surname = surnameTextField?.text else {
                return false
        }

        let birthday = datePicker?.date

        if gender == nil {
            UIAlertController.showSimpleAlertViewWithText("Please select your gender".localized,
                                                          title: "Ouch".localized,
                                                          controller: self,
                                                          completion: nil,
                                                          alertHandler: nil)
            return false
        }

        if birthday?.age < 18 && birthday != nil {
                UIAlertController.showSimpleAlertViewWithText("You must be at least 18, to use Friends".localized,
                                                              title: "Ouch".localized,
                                                              controller: self,
                                                              completion: nil,
                                                              alertHandler: nil)
                return false

        }

        if name.isEmpty {
            UIAlertController.showSimpleAlertViewWithText("Please enter your name".localized,
                                                          title: "Ouch".localized,
                                                          controller: self,
                                                          completion: nil,
                                                          alertHandler: nil)
            return false
        }

        if surname.isEmpty {
            UIAlertController.showSimpleAlertViewWithText("Please enter your surname".localized,
                                                          title: "Ouch".localized,
                                                          controller: self,
                                                          completion: nil,
                                                          alertHandler: nil)
            return false
        }

        return true
    }
}




