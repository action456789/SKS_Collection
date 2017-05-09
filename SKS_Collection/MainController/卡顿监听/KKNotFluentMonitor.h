//
//  KKNotFluentMonitor.h
//  SKS_Collection
//
//  Created by sen.ke on 2017/5/4.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"

@interface KKNotFluentMonitor : NSObject
singleton_interface(KKNotFluentMonitor)

- (void)startMonitor;
- (void)endMonitor;

@end
