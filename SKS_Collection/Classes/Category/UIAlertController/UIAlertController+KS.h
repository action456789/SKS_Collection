//
//  UIAlertController+KS.h
//  KSAlert
//
//  Created by KeSen on 15/12/1.
//  Copyright © 2015年 KeSen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ __nullable KSAlertBlock)(UIAlertAction * _Nullable action);

#define PARST(A, B) A##B
#if !defined(PROALERT_MESSAGE_DICT)
    #define ALERT_MESSAGE_DICT_(title, message, cancel, confirm, t, m, can, con) ({\
        __typeof__(title) t = title;\
        __typeof__(message) m = message;\
        __typeof__(cancel) can = cancel;\
        __typeof__(confirm) con = confirm;\
        @{  @"title"   : NSLocalizedString(t, nil),\
            @"message"     : NSLocalizedString(m, nil),\
            @"cancel"      : NSLocalizedString(can, nil),\
            @"confirm"     : NSLocalizedString(con, nil) };\
        })

    #define PROALERT_MESSAGE_DICT(title, message, cancel, confirm) ALERT_MESSAGE_DICT_(title, message, cancel, confirm, PARST(__title, __COUNTER__), PARST(__message, __COUNTER__), PARST(__cancel, __COUNTER__), PARST(__confirm, __COUNTER))
#endif

@interface UIAlertController (KS)

/**
 *  弹框 >= iOS8
 *
 *  @param presentedController   需要弹框的控制器
 *  @param dict         弹框标题、消息、取消文字、确定文字
 *  @param cancelBlock  取消 回调
 *  @param confirmBlock 确定 回调
 
 dict格式如下：
 
 NSDictionary * dic2 = @{   
    @"title"   : @"提示?",
    @"message" : @"确定要退出吗？",
    @"cancel"  : @"取消",
    @"confirm" : @"确定"};
 */

+ (instancetype _Nullable )ks_alertControllerWithMessage:(NSDictionary *_Nonnull)dict cancelBlock:(KSAlertBlock)cancelBlock confirmBlock:(KSAlertBlock)confirmBlock;

@end
