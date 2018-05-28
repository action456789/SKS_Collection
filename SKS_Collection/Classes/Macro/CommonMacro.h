//
//  Common.h
//  SKS_Collection
//
//  Created by KeSen on 9/22/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#ifndef CommonMacro_h
#define CommonMacro_h

// 判断是否是横屏
#define kLandscape UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)

// 不同版本下，返回的结果不同，因此不可用
// 宽度
//#define kScreenWidth    (kLandscape ? [[UIScreen mainScreen] bounds].size.height : [[UIScreen mainScreen] bounds].size.width)
// 高度
//#define kScreenHeight   (kLandscape ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen]  bounds].size.height)

// 宽度
#define kScreenWidth    ([UIApplication sharedApplication].keyWindow.rootViewController.view.bounds.size.width)
// 高度
#define kScreenHeight   ([UIApplication sharedApplication].keyWindow.rootViewController.view.bounds.size.height)

// 设备唯一标识符
#define kDeviceUUID = [[[UIDevice currentDevice] identifierForVendor] UUIDString]
// 设备类型
#define kDevice_iPhone4_4s   (kScreenWidth == 320.f && kScreenHeight == 480.f ? YES : NO)
#define kDevice_iPhone5_5s   (kScreenWidth == 320.f && kScreenHeight == 568.f ? YES : NO)
#define kDevice_iPhone6      (kScreenWidth == 375.f && kScreenHeight == 667.f ? YES : NO)
#define kDevice_iPhone6_plus (kScreenWidth == 414.f && kScreenHeight == 736.f ? YES : NO)
// 判断是否为iPhone
#define kIPhoneDevice [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone
// 判断是否为iPad
#define kIPadDevice [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad

// 判断是否为iOS7
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)
// 判断是否为iOS8
#define iOS8 ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0)

# pragma mark - 字符串判断
// 判断一个数组是否合法
#define IsValidateArr(arr) ((arr && [arr isKindOfClass:[NSArray class]] && arr.count > 0))
// 判断从后台服务器获取的result是否合法
#define IsValidateResult(result) ((nil != result && [result isKindOfClass:[NSDictionary class]] && [[result objectForKey:@"result"] isEqualToString:REQUEST_SUCCESSFULLY]))
// 判断一个字典是否合法
#define IsValidateDic(dic) (nil != dic && [dic isKindOfClass:[NSDictionary class]] && dic.count > 0)
// 判断一个NSString是否合法
#define IsValidateString(str) ((nil != str) && ([str isKindOfClass:[NSString class]]) && (str.length > 0) && (![str isEqualToString:@"(null)"]) && ((NSNull *) str != [NSNull null]))

//是否是空对象
#define kObjectIsEmpty(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))


//一些缩写
#define kApplication        [UIApplication sharedApplication]
#define kKeyWindow          [UIApplication sharedApplication].keyWindow
#define kAppDelegate        [UIApplication sharedApplication].delegate
#define kUserDefaults       [NSUserDefaults standardUserDefaults]
#define kNotificationCenter [NSNotificationCenter defaultCenter]

//颜色
#define kRGBColor(r, g, b)     [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define kRGBAColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(r)/255.0 blue:(r)/255.0 alpha:a]
#define kRandomColor  KRGBColor(arc4random_uniform(256)/255.0,arc4random_uniform(256)/255.0,arc4random_uniform(256)/255.0)

#define kColorWithHex(rgbValue) \
    [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 \
    green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 \
    blue:((float)(rgbValue & 0xFF)) / 255.0 alpha:1.0]

//弱引用/强引用
#define kWeakSelf(type)   __weak typeof(type) weak##type = type;
#define kStrongSelf(type) __strong typeof(type) type = weak##type;

//由角度转换弧度
#define kDegreesToRadian(x)      (M_PI * (x) / 180.0)
//由弧度转换角度
#define kRadianToDegrees(radian) (radian * 180.0) / (M_PI)

//获取一段时间间隔
#define kStartTime CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();
#define kEndTime   NSLog(@"Time: %f", CFAbsoluteTimeGetCurrent() - start)


#endif /* Common_h */
