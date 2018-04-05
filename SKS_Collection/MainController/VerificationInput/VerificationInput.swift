//
//  InputValidator.swift
//  RICISmartSwift
//
//  Created by sen.ke on 2017/5/26.
//  Copyright © 2017年 ke sen. All rights reserved.
//

import UIKit

class VerificationInput: NSObject {
    // 抽象方法，由子类重载
    func validate(input: String) -> Bool {
        preconditionFailure("This method must be overridden")
    }
    
    var errorMessage: String?
}

@objc class VerificationSpecialChar: VerificationInput {
    let set = CharacterSet.init(charactersIn: "~`!@#$%^&*()+=-/;:\"\'{}[]<>^?, ")
    
    override func validate(input: String) -> Bool {
        if input.rangeOfCharacter(from: set) != nil {
            self.errorMessage = "不能含有特殊字符"
        }
        
        return self.errorMessage == nil
    }
}

class VerificationEmail: VerificationInput {
    override func validate(input: String) -> Bool {
        if input.count <= 0 {
            self.errorMessage = "请输入正确的邮箱"
        } else {
            if input.kk_isEmail() {
                self.errorMessage = nil
            } else {
                self.errorMessage = "请输入正确的邮箱"
            }
        }
        
        return self.errorMessage == nil
    }
}

class VerificationPhone: VerificationInput {
    override func validate(input: String) -> Bool {
        if input.count <= 0 {
            self.errorMessage = "请输入正确的手机号"
        } else {
            if input.kk_isPhoneNumber() {
                self.errorMessage = nil
            } else {
                self.errorMessage = "请输入正确的手机号"
            }
        }
        
        return self.errorMessage == nil
    }
}

class VerificationPwd: VerificationInput {
    override func validate(input: String) -> Bool {
        if input.count <= 0 {
            self.errorMessage = "密码不能为空"
        } else {
            if input.count < 5 {
                self.errorMessage = "请输入6位以上密码"
            } else if input.count > 20 {
                self.errorMessage = "密码长度不能超过20位"
            } else {
                self.errorMessage = nil
            }
        }
        
        return self.errorMessage == nil
    }
}

class VerificationMacAddress: VerificationInput {
    override func validate(input: String) -> Bool {
        if input.count <= 0 {
            self.errorMessage = "不是有效的 MAC 地址"
        } else {
            if input.kk_isMacAddress() {
                self.errorMessage = nil
            } else {
                self.errorMessage = "不是有效的 MAC 地址"
            }
        }
        
        return self.errorMessage == nil
    }
}


