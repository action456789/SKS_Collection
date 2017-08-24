//
//  UIViewController+activity.swift
//  RICISmartSwift
//
//  Created by sen.ke on 2017/7/13.
//  Copyright © 2017年 ke sen. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

extension UIViewController {
    func showHUDInWindow(message: String = "", isMaskNavBar: Bool = false) {
        let size = CGSize(width: 30, height: 30)
        let activityData = ActivityData(size: size,
                                        message: "",
                                        type: .lineScalePulseOut,
                                        displayTimeThreshold: 5)
        activityData.topOffset = isMaskNavBar ? -64 : 0
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
    }
    
    func hideHUDInWindow() {
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
    }
}
