//
//  KKWeek+Extension.swift
//  RICISmartSwift
//
//  Created by sen.ke on 2018/1/15.
//  Copyright © 2018年 ke sen. All rights reserved.
//

import Foundation

extension KKDay {
    // 从 "2,4,5" 的字符串中返回 KKDay 数组
    class func daysFrom(str: String?) -> [KKDay] {
        var days = [KKDay]()
        if let dayStrings = str?.split(separator: ",") {
            let newDayStrings = dayStrings.map({String.init($0)})
            let daysIndex = newDayStrings.map({Int($0)})
            for index in daysIndex {
                guard let index = index else {continue}
                let d: KKDay = KKDay.init(index: index)
                days.append(d)
            }
        }
        return days
    }
}
