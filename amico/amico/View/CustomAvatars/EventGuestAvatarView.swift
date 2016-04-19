//
//  EventGuestAvatarView.swift
//  amico
//
//  Created by Yuriy B. on 4/14/16.
//  Copyright © 2016 perpet.io. All rights reserved.
//

import UIKit

enum GuestStatus {
    case Going
    case NotSure
    case NotGoing
}

final class EventGuestAvatarView: UIView {

    @IBOutlet private weak var userAvatarImageView: UIImageView?
    @IBOutlet private weak var userStatusImageView: UIImageView?
    @IBOutlet private weak var overlayView: UIView?
    @IBOutlet private weak var overlayCounterLabel: UILabel?

    var userStatus: GuestStatus? {
        didSet {
            setUserStatusImage()
        }
    }
}

private extension EventGuestAvatarView {
    //MARK:- UI Setup
    func setupView() {
        userAvatarImageView?.layer.cornerRadius = (userAvatarImageView?.frame.width ?? 0) / 2
        userStatusImageView?.layer.cornerRadius = (userStatusImageView?.frame.width ?? 0) / 2
        overlayView?.hidden = true
    }

    func setUserStatusImage() {
        guard let userStatus = userStatus else {
            return
        }

        switch userStatus {
        case .Going:
            userStatusImageView?.image = UIImage(named: "approve")
        case .NotGoing:
            userStatusImageView?.image = UIImage(named: "disparove")
        case .NotSure:
            userStatusImageView?.image = UIImage(named: "not_sure")
        }
    }
}
