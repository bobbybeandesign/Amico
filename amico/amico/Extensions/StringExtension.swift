//
//  StringExtension.swift
//  amico
//
//  Created by Yuriy B. on 4/5/16.
//  Copyright © 2016 perpet.io. All rights reserved.
//

import Foundation

extension String {
    /**
     Returns the localized version of self.
     */
    var localized: String {
        return NSLocalizedString(self,
                                 tableName: nil,
                                 bundle: NSBundle.mainBundle(),
                                 value: "",
                                 comment: "")
    }

    /**
     Returns true if string is a valid email address.
     */
    func isEmail() -> Bool {
        let regex = try! NSRegularExpression(pattern: "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,4}$",
                                             options: [.CaseInsensitive])

        return regex.firstMatchInString(self, options:[],
                                        range: NSMakeRange(0, utf16.count)) != nil
    }
}