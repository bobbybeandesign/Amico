//
//  SideMenuSeparatorHeader.swift
//  amico
//
//  Created by Yuriy B. on 4/6/16.
//  Copyright © 2016 perpet.io. All rights reserved.
//

import UIKit

final class SideMenuSeparatorHeader: UIView {
    class func instanceFromNib() -> SideMenuSeparatorHeader {
        guard let instance =  NSBundle.mainBundle().loadNibNamed("SideMenuSeparatorHeader", owner: self, options: nil).first as? SideMenuSeparatorHeader else {
            return SideMenuSeparatorHeader()
        }
        return instance
    }
}