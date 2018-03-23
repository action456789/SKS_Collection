//
//  SQLiteTool.swift
//  RICISmartSwift
//
//  Created by sen.ke on 2017/5/24.
//  Copyright © 2017年 ke sen. All rights reserved.
//

import UIKit
import FMDB

class SQLiteTool: NSObject {
    private let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    private var dbName = "Default.db"
    private var dbPath: URL {
        return URL(fileURLWithPath: self.documentPath).appendingPathComponent(self.dbName)
    }
    
    lazy var dbQueue: FMDatabaseQueue? = {
        let queue = FMDatabaseQueue(path: self.dbPath.path)
        return queue
    }()
    
    init(dbName: String = "Default.db") {
        super.init()
        self.dbName = dbName
    }
    
    deinit {
        dbQueue?.close()
    }
    
    // 业务相关
//    func save(floor: FloorModel) {
//        self.dbQueue?.inTransaction({ db, rollback in
//            do {
//                try db.executeUpdate("create table if not exists floor (id text PRIMARY KEY, name text)", values: nil)
//                try db.executeUpdate("INSERT INTO floor (id, name) VALUES (?, ?)", values: [floor.id, floor.name])
//            } catch {
//                rollback.pointee = true
//            }
//        })
//    }
}
