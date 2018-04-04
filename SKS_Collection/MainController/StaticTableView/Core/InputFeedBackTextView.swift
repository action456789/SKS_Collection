//
//  RiciTextInputView.swift
//  RICISmartSwift
//
//  Created by sen.ke on 2017/6/14.
//  Copyright © 2017年 ke sen. All rights reserved.
//

import UIKit
import SnapKit

class InputFeedBackTextView: UIView {

    var textView = UITextView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        textView.placeholder = "请描述遇到的问题和现象"
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.textColor = UIColor.init(rgb: 0x666666)
        
        self.addSubview(textView)
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
        textView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(15)
            make.right.equalTo(self).offset(-15)
            make.bottom.equalTo(self).offset(-8)
            make.top.equalTo(self).offset(10)
        }
        super.updateConstraints()
    }
}

