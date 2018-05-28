//
//  KKSegmentControlDemoVC.swift
//  SKS_Collection
//
//  Created by ke sen. on 2018/4/4.
//  Copyright © 2018年 SenKe. All rights reserved.
//

import UIKit
import SnapKit

class KKSegmentControlDemoVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let titles = ["哈喽", "弓箭女皇", "野蛮人之王", "头号玩家", "哈哈哈", "哈喽", "弓箭女皇", "野蛮人之王", "头号玩家", "哈哈哈"]
        let config = KKSegmentControlAppearance()
        let layout = KKSegmentControlLayoutAuto(itemTitles: titles, config: config)
        let vc = KKSegmentControlVC(itemTitles: titles, layout: layout)
        vc.delegate = self
        
        self.view.addSubview(vc.view)
        self.addChildViewController(vc)
        
        vc.view.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view).inset(UIEdgeInsets(top: 80, left: 0, bottom: 0, right: 0))
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension KKSegmentControlDemoVC: KKSegmentControlVCDelegate {
    func segmentControlVC(_ segmentControl: KKSegmentControlVC, viewControllerForPageAt index: Int) -> UIViewController {
        let controller = KKSegmentControlDemoPageVC()
        return controller
    }
}
