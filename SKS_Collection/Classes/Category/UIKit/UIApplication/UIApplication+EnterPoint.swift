//
//  UIApplication+EnterPoint.swift
//  RICISmartSwift
//
//  Created by sen.ke on 2017/6/13.
//  Copyright © 2017年 ke sen. All rights reserved.
//

import Foundation

// 解决 swift 下 + (void)initialize 方法被废弃的问题
//  instead of implementing initialize(), conform to SelfAware and implement the defined method, awake().
// https://stackoverflow.com/questions/42824541/swift-3-1-deprecates-initialize-how-can-i-achieve-the-same-thing

protocol SelfAware: class {
    static func awake()
}

class NothingToSeeHere {
    
    static func harmlessFunction() {
        
        let typeCount = Int(objc_getClassList(nil, 0))
        let types = UnsafeMutablePointer<AnyClass?>.allocate(capacity: typeCount)
        let autoreleasingTypes = AutoreleasingUnsafeMutablePointer<AnyClass?>(types)
        objc_getClassList(autoreleasingTypes, Int32(typeCount))
        for index in 0 ..< typeCount { (types[index] as? SelfAware.Type)?.awake() }
        types.deallocate(capacity: typeCount)
    }
}

extension UIApplication {
    
    private static let runOnce: Void = {
        NothingToSeeHere.harmlessFunction()
    }()
    
    override open var next: UIResponder? {
        // Called before applicationDidFinishLaunching
        UIApplication.runOnce
        return super.next
    }
}
