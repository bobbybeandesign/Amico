//
//  SideMenuTableViewCell.swift
//  amico
//
//  Created by Yuriy B. on 4/6/16.
//  Copyright © 2016 perpet.io. All rights reserved.
//

import UIKit

final class SideMenuTableViewCell: UITableViewCell {
    static let nib = UINib(nibName: "SideMenuTableViewCell", bundle: nil)
    static let reuseIdentifier = "sideMenuTableViewCell"

    @IBOutlet private weak var iconImageView: UIImageView?
    @IBOutlet private weak var cellNameLabel: UILabel?

    var cellType: LeftMenuItem? {
        didSet{
            setupUI()
        }
    }
}

private extension SideMenuTableViewCell {
    //MARK:- Setup UI
    func setupUI() {
        cellNameLabel?.text = cellType?.rawValue
        if let image =  cellType?.image {
            iconImageView?.image = image
        }
    }
}