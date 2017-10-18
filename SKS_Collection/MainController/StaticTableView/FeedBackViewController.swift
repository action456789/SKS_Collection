//
//  FeedBackViewController.swift
//  RICISmartSwift
//
//  Created by sen.ke on 2017/6/13.
//  Copyright © 2017年 ke sen. All rights reserved.
//

import UIKit
import MBProgressHUD

class FeedBackViewController: StaticCellBaseViewController {
    var selectedQuestionType = "17"
    
    var item1: StaticCellItem?
    
    var contactInputView = InputContactView(frame: CGRect(x: 0, y: 0, width: ScreenWidth - 16, height: 50))
    var questionInputView = InputFeedBackTextView(frame: CGRect(x: 0, y: 0, width: ScreenWidth - 16, height: 150))
    
    override func viewDidLoad() {
        super.viewDidLoad()

        edgesForExtendedLayout = []

        self.view.backgroundColor = UIColor.init(rgb: 0xf2f4f5)
        
        let item1 = StaticCellItem(title: "问题描述", icon: nil, objectClass: nil)
        item1?.clickedHandle = { _ in

        }
        self.item1 = item1
        
        let item2 = StaticCellItem(title: "涉及设备", icon: nil, objectClass: nil)
        item2?.clickedHandle = { _ in

        }
        
        let group1 = StaticCellItemGroup(items: [item1!, item2!])
        group1?.footerHeight = 8
        
        let itemContactInput = StaticCellItem(title: nil, icon: nil, objectClass: nil)
        itemContactInput?.isShowIndicator = false
        itemContactInput?.customerView = self.contactInputView
        
        let itemTextView = StaticCellItem(title: nil, icon: nil, objectClass: nil)
        itemTextView?.isShowIndicator = false
        itemTextView?.customerView = self.questionInputView
        
        let group2 = StaticCellItemGroup(items: [itemContactInput!, itemTextView!])
        group2?.footerHeight = 8
        
        let itemHistory = StaticCellItem(title: "反馈历史", icon: nil, objectClass: nil)
        let group3 = StaticCellItemGroup(items: [itemHistory!])
        
        self.dataArray = [group1!, group2!, group3!]
        
        let padding: CGFloat = 8
        let frame = CGRect(x: padding, y: padding, width: CGFloat(ScreenWidth - padding * 2), height: ScreenHeightApartNav)
        self.tableView.frame = frame
        
        self.isShowCornerRadio = true
    }
    
    override func viewForFooter(inSection section: Int) -> UIView! {
        return UIView()
    }
}


