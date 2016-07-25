//
//  DiskCacheSqlLiteDemoController.m
//  SKS_Collection
//
//  Created by KeSen on 7/22/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import "DiskCacheSqlLiteDemoController.h"
#import "DiskCacheSqlLite.h"

@implementation DiskCacheSqlLiteDemoController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    DiskCacheSqlLite *cache = [[DiskCacheSqlLite alloc] init];
    
    // cache string
    NSString *string = @"我叫你一声，你敢答应吗";
    [cache dbAddItemWithKey:@"stringKey" value:string];
    NSLog(@"_____%@", [cache dbGetItemWithKey:@"stringKey"]);
    
    // update string cache
    [cache dbUpdateItemWithKey:@"stringKey" value:@"刘梦霞个傻逼"];
    NSLog(@"_____%@", [cache dbGetItemWithKey:@"stringKey"]);
    
    // cache array
    NSArray *array = @[@"sdfa", @"我是测试数据", @"贱人就是矫情"];
    NSString *arrayKey = @"arrayKey";
    [cache dbAddItemWithKey:arrayKey value:array];
    NSLog(@"_____%@", [cache dbGetItemWithKey:arrayKey]);
    
    // cache image TODO: error
//    [cache dbAddItemWithKey:@"imageKey" value:[UIImage imageNamed:@"girl"]];
//    UIImage *imageFromCache = (UIImage *)[cache dbGetItemWithKey:@"imageKey"];
    
//    UIImage *originImg = [UIImage imageNamed:@"girl"];
//    NSData *imageData = [NSKeyedArchiver archivedDataWithRootObject:originImg];
//    UIImage *imageCopy = [NSKeyedUnarchiver unarchiveObjectWithData:imageData];
//    UIImageView *imageView = [[UIImageView alloc] initWithImage:imageCopy];
//    [self.view addSubview:imageView];
//    imageView.center = self.view.center;
    
}

@end
