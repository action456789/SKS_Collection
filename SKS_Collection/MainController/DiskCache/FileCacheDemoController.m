//
//  CacheDemoController.m
//  SKS_Collection
//
//  Created by KeSen on 7/21/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import "FileCacheDemoController.h"
#import "DiskCacheFile.h"

static NSString *arrayKey = @"arrayKey";

@implementation FileCacheDemoController
{
    DiskCacheFile *_cacheFile;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSArray *array = @[@"sdfa", @"我是测试数据", @"贱人就是矫情"];
    _cacheFile = [[DiskCacheFile alloc] init];
    _cacheFile.expiredTimeInterval = 60;
    [_cacheFile setObject:array forKey:arrayKey];
    
    NSLog(@"____%@", _cacheFile);
    
    UIImage *image = [UIImage imageNamed:@"girl"];
    [_cacheFile setObject:image forKey:@"imageKey"];
    
    UIImage *imageFromCache = (UIImage *)[_cacheFile objectForKey:@"imageKey"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:imageFromCache];
    [self.view addSubview:imageView];
    imageView.center = self.view.center;
}

@end
