//
//  DeviceInfoViewController.swift
//  RICISmartSwift
//
//  Created by sen.ke on 2017/5/16.
//  Copyright © 2017年 ke sen. All rights reserved.
//

import UIKit
import SnapKit

class StaticCollectionViewDemo3VC: UIViewController {
    
    let deviceCollectionView: UIView = {
        var item1 = StaticCollectionViewCellItem(imageName: "optimizest", title: "一楼/客厅", handle: { (cell, imageVIew, label) in
            
        })
        var item2 = StaticCollectionViewCellItem(imageName: "optimizest", title: "二楼/主卧", handle: { (cell, imageVIew, label) in
            
        })
        var item3 = StaticCollectionViewCellItem(imageName: "optimizest", title: "二楼/客厅", handle: { (cell, imageVIew, label) in
            
        })
        var item4 = StaticCollectionViewCellItem(imageName: "optimizest", title: "地下室", handle: { (cell, imageVIew, label) in
            
        })
        var item5 = StaticCollectionViewCellItem(imageName: "optimizest", title: "地下室", handle: { (cell, imageVIew, label) in
            
        })
        var item6 = StaticCollectionViewCellItem(imageName: "optimizest", title: "地下室", handle: { (cell, imageVIew, label) in
            
        })
        
        var array: [StaticCollectionViewCellItem] = [item1!, item2!, item3!, item4!, item5!, item6!]
        
        let lineSpacing = CGFloat(10)
        let topTailPadding = CGFloat(0)
        
        var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let emptyAreaWidth = lineSpacing * CGFloat(array.count - 1) + topTailPadding * 2
        
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.minimumLineSpacing = lineSpacing
        layout.minimumInteritemSpacing = 0
        layout.headerReferenceSize = CGSize(width: topTailPadding, height: 0)
        layout.footerReferenceSize = CGSize(width: topTailPadding, height: 0)
        
        let rect = CGRect(x: CGFloat(10), y: CGFloat(200 - 18), width: CGFloat(ScreenWidth - 20), height: CGFloat(90))
        var collectionView = StaticCollectionView(frame: rect,
                                                  layout: layout,
                                                  registerCell: StaticCollectionViewDemo2Cell.self,
                                                  dataArray: array)
        collectionView?.backgroundColor = UIColor.white
        
        return collectionView!
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(deviceCollectionView)
        
        deviceCollectionView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.view)
            make.centerY.equalTo(self.view)
            make.height.equalTo(100)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}
