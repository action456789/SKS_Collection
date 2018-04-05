//
//  CountDownBtnDemoVC.swift
//  SKS_Collection
//
//  Created by ke sen. on 2018/4/5.
//  Copyright © 2018年 SenKe. All rights reserved.
//

import UIKit
import SnapKit

class CountDownBtnDemoVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let btn = KKCountDownButton(type: .custom)
        btn.setTitle("60", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        view.addSubview(btn)
        btn.snp.makeConstraints { (make) in
            make.center.equalTo(view)
        }
        
        // 设置倒计时
        btn.timeLength = 60
        btn.clickHandle = { sender in
            print(#function)
            
            sender.startCountDown()
        }
    }
}
