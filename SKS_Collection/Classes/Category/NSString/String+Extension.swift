//
//  String+Extension.swift
//  RICISmartSwift
//
//  Created by sen.ke on 2017/5/17.
//  Copyright © 2017年 ke sen. All rights reserved.
//

import Foundation

// MARK: Localize
extension String {
    var kk_localized: String {
        return Bundle.main.localizedString(forKey: self, value: nil, table: nil)
    }
}

extension String {
    var kk_float: Float {
        return (self as NSString).floatValue
    }
}
