//
//  UIAlertController+KS.h
//  KSAlert
//
//  Created by KeSen on 15/12/1.
//  Copyright © 2015年 KeSen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (KS)

#define PARST(A, B) A##B

#if !defined(PROALERT_MESSAGE_DICT)

#define ALERT_MESSAGE_DICT1_(title, message, cancel, confirm, t, m, can, con) ({\
__typeof__(title) t = title;\
__typeof__(message) m = message;\
__typeof__(cancel) can = cancel;\
__typeof__(confirm) con = confirm;\
@{  @"title"   : NSLocalizedString(t, nil),\
@"message"     : NSLocalizedString(m, nil),\
@"cancel"      : NSLocalizedString(can, nil),\
@"confirm"     : NSLocalizedString(con, nil) };\
})

#define ALERT_MESSAGE_DICT2_(title, message, cancel, confirm, t, m, can, con) ({\
__typeof__(title) t = title;\
__typeof__(message) m = message;\
__typeof__(cancel) can = cancel;\
__typeof__(confirm) con = confirm;\
@{  @"title"   : t,\
@"message"     : m,\
@"cancel"      : can,\
@"confirm"     : con };\
})

#define LOCALIZED_MESSAGE_DICT(title, message, cancel, confirm) ALERT_MESSAGE_DICT1_(title, message, cancel, confirm, PARST(__title, __COUNTER__), PARST(__message, __COUNTER__), PARST(__cancel, __COUNTER__), PARST(__confirm, __COUNTER))

#define MESSAGE_DICT(title, message, cancel, confirm) ALERT_MESSAGE_DICT2_(title, message, cancel, confirm, PARST(__title, __COUNTER__), PARST(__message, __COUNTER__), PARST(__cancel, __COUNTER__), PARST(__confirm, __COUNTER))
#endif

NS_ASSUME_NONNULL_BEGIN

typedef void (^KSAlertBlock)(UIAlertAction *action);

/**
 *  弹框
 *
 *  @param dict         弹框标题、消息、取消文字、确定文字
 *  @param cancelBlock  取消 回调
 *  @param confirmBlock 确定 回调
 
 dict格式如下：
 
 NSDictionary * dic2 = @{
 @"title"   : @"提示?",
 @"message" : @"确定要退出吗？",
 @"cancel"  : @"取消",
 @"confirm" : @"确定"};
 
 快速创建一个字典：NSDictionary *messageDict = PROALERT_MESSAGE_DICT(@"global_alert_starttakeoff", @"", @"alert_button_cancel", @"alert_button_comfirm");
 */

+ (instancetype)kk_controllerWithMessage:(NSDictionary *)dict cancelBlock:(__nullable KSAlertBlock)cancelBlock confirmBlock:(__nullable KSAlertBlock)confirmBlock;

+ (void)kk_showMessage:(NSString *)message fromViewControler:(UIViewController *)from;

NS_ASSUME_NONNULL_END

@end

