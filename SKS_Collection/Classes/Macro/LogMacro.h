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
#define KSColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

// 自定义Log
#ifdef DEBUG
#define KSLog(...) NSLog(__VA_ARGS__)
#else
#define KSLog(...)
#endif

// 快速定义 weak self
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

#endif
