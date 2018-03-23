//
//  ArchiverTool.swift
//  RICISmartSwift
//
//  Created by sen.ke on 2017/4/13.
//  Copyright © 2017年 ke sen. All rights reserved.
//  支持 Swift4 以上版本

import UIKit

class ArchiverTool: NSObject {
    
    public let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    
    private var fileName = "Default.info"
    private var archiveredClass: Any?
    
    let errorMsg = "ArchiverTool Error:"
    
    init(savedfileName: String) {
        super.init()
        self.fileName = savedfileName
    }
    
    private var filePath: URL {
        return URL(fileURLWithPath: documentPath).appendingPathComponent(self.fileName)
    }
    
    private var huxingMapImagePath: URL {
        return URL(fileURLWithPath: documentPath).appendingPathComponent("HuxingMap.png")
    }
    
    public func clean() {
        if FileManager.default.fileExists(atPath: self.filePath.path) {
            try? FileManager.default.removeItem(at: self.filePath)
        }
    }
    
    public func savaImage(image: UIImage?) {
        if image != nil {
            try? UIImagePNGRepresentation(image!)?.write(to: huxingMapImagePath, options: .atomic)
        }
    }
    
    public func readImage() -> UIImage? {
        var image : UIImage?
        
        let path = huxingMapImagePath.path
        if FileManager.default.fileExists(atPath: path) {
            if let newImage = UIImage(contentsOfFile: path)  {
                image = newImage
            } else {
                print(errorMsg + "getImage() [Warning: file exists at \(path) :: Unable to create image]")
            }
        } else {
            print(errorMsg + "getImage() [Warning: file does not exist at \(path)]")
        }
        return image
    }
    
    // MARK: - NSCoding
    // 保存实现了NSCoding协议的对象
    @discardableResult
    public func saveNSCodingObj(obj: NSCoding) -> Bool {
        let data = NSKeyedArchiver.archivedData(withRootObject: obj)
        do {
            try data.write(to: filePath, options: .atomic)
            return false
        } catch {
            print(errorMsg + error.localizedDescription)
            return true
        }
    }
    
    // 读取保存的对象
    public func readNSCodingObj() -> NSCoding? {
        if FileManager.default.fileExists(atPath: filePath.path) {
            do {
                let data = try Data(contentsOf: filePath)
                return NSKeyedUnarchiver.unarchiveObject(with: data) as? NSCoding
            } catch {
                print(errorMsg + error.localizedDescription)
                return nil
            }
        }
        return nil
    }
    
    // MARK: - Codable
    // 保存实现了Codable协议的对象
    public func saveCodaleObject<T: Codable>(obj: T) -> Bool {
        do {
            let jsonData = try JSONEncoder().encode(obj)
            try jsonData.write(to: filePath, options: .atomic)
            return true
        } catch {
            print(errorMsg + error.localizedDescription)
            return false
        }
    }
    
    public func readCodaleObject<T: Codable>() -> T? {
        if FileManager.default.fileExists(atPath: filePath.path) {
            do {
                let data = try Data(contentsOf: filePath)
                let obj = try JSONDecoder().decode(T.self, from: data)
                return obj
            } catch {
                print(errorMsg + error.localizedDescription)
                return nil
            }
        }
        return nil
    }
    
    // TODO: 写成一个方法
    //    public func save<T>(obj: T) -> Bool {
    //        if let newObj = obj as? NSCoding {
    //            return saveNSCodingObj(obj: newObj)
    //        }
    //
    //        if let newObj = obj.self as? Codable.Type {
    //            return saveCodaleObject(obj: newObj)
    //        }
    //
    //        print(errorMsg + "obj 必须实现 NSCoding 或 Codable 协议")
    //        return false
    //    }
}
