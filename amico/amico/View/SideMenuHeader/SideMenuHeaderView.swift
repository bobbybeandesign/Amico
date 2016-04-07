//
//  SideMenuHeaderView.swift
//  amico
//
//  Created by Yuriy B. on 4/5/16.
//  Copyright © 2016 perpet.io. All rights reserved.
//

import UIKit

final class SideMenuHeaderView: UIView {

    @IBOutlet private weak var nameLabel: UILabel?
    @IBOutlet private weak var backgroundImageView: UIImageView?
    @IBOutlet private weak var profileImageView: UIImageView?

    class func instanceFromNib() -> SideMenuHeaderView {
        guard let instance =  NSBundle.mainBundle().loadNibNamed("SideMenuHeaderView", owner: self, options: nil).first as? SideMenuHeaderView else {
            return SideMenuHeaderView()
        }
        return instance
    }
}

private extension SideMenuHeaderView {
    //MARK:- UI Setup
    func setupUI() {
        profileImageView?.layer.cornerRadius = (profileImageView?.frame.height ?? 0) / 2
    }
}