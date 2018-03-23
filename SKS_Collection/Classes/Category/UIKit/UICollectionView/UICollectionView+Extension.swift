//
//  Extension.swift
//  RICISmartSwift
//
//  Created by sen.ke on 2017/12/1.
//  Copyright © 2017年 ke sen. All rights reserved.
//


extension UICollectionView {
    /// 计算UICollectionView的行数
    ///
    /// - Parameters:
    ///   - lineCount: 列数, Int
    ///   - dataArrayCount: 数据源数据个数, Int
    func kk_lineCount(lineCount: Int, dataArrayCount: Int) -> Int {
        var count = 0
        if dataArrayCount % lineCount == 0 {
            count = dataArrayCount / lineCount
        } else {
            count = dataArrayCount / lineCount + 1
        }
        return count
    }
    
    /// 获取 UICollectionView 内容的高度
    /// https://stackoverflow.com/questions/13788522/how-to-determine-height-of-uicollectionview-with-flowlayout
    /// - Returns: CGSize
    func kk_contentSize() -> CGSize {
        return self.collectionViewLayout.collectionViewContentSize
    }
}
