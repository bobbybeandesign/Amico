//
//  NSDateExtension.swift
//  amico
//
//  Created by Yuriy B. on 4/12/16.
//  Copyright © 2016 perpet.io. All rights reserved.
//

import Foundation

extension NSDate {
    
    var age: Int {
       return NSCalendar.currentCalendar().components(.Year, fromDate: self, toDate: NSDate(), options: []).year
    }
}