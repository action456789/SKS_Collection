//
//  Dispatch+Extension.swift
//  RICISmartSwift
//
//  Created by sen.ke on 2017/5/19.
//  Copyright © 2017年 ke sen. All rights reserved.
//

import Foundation

extension DispatchQueue {
    
    /// dispatch_once
    
    private static var _onceTracker = [String]()
    
    public class func once(file: String = #file, function: String = #function, line: Int = #line, block:(Void)->Void) {
        let token = file + ":" + function + ":" + String(line)
        once(token: token, block: block)
    }

    /**
     Executes a block of code, associated with a unique token, only once.  The code is thread safe and will
     only execute the code once even in the presence of multithreaded calls.
     
     - parameter token: A unique reverse DNS style name such as com.vectorform.<name> or a GUID
     - parameter block: Block to execute once
     */
    public class func once(token: String, block:()->Void) {
        objc_sync_enter(self); defer { objc_sync_exit(self) }
        
        if _onceTracker.contains(token) {
            return
        }
        
        _onceTracker.append(token)
        block()
    }
    
    /// dispatch_after
    func after(_ delay: TimeInterval, execute closure: @escaping () -> Void) {
        asyncAfter(deadline: .now() + delay, execute: closure)
    }
}
