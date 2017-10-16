//
//  KSHead.h
//  KSCollects
//
//  Created by KeSen on 15/9/15.
//  Copyright (c) 2015年 KeSen. All rights reserved.
//

#ifndef LogMacro
#define LogMacro

// 获得RGB颜色
#define KKColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

// 自定义Log
#ifdef DEBUG // 处于开发阶段
#define  KKLog(s, ... ) NSLog( @"<[文件名:%@]:[行数:%d] [内容:%@]", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else // 处于发布阶段
#define KKLog(...)
#endif

// 快速定义 weak self
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

#endif
