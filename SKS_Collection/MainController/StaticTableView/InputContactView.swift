//
//  InputView.swift
//  RICISmartSwift
//
//  Created by sen.ke on 2017/6/14.
//  Copyright © 2017年 ke sen. All rights reserved.
//

import UIKit
import SnapKit

class InputContactView: UIView {

    let textField = UITextField()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.clear
        
        textField.borderStyle = .none
        textField.placeholder = "请输入联系电话号码"
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.textColor = UIColor.init(rgb: 0x333333)
        self.addSubview(textField)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open class var requiresConstraintBasedLayout: Bool {
        get {
            return true
        }
    }
    
    override func updateConstraints() {
        textField.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(15)
            make.right.equalTo(self).offset(-15)
            make.bottom.equalTo(self).offset(-8)
            make.top.equalTo(self).offset(8)
        }
        super.updateConstraints()
    }
}
