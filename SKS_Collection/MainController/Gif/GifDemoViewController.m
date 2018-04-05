//
//  GifDemoViewController.m
//  SKS_Collection
//
//  Created by KeSen on 8/17/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import "GifDemoViewController.h"
#import <SDWebImage/SDWebImageManager.h>
#import "CicleProgressAnimationView.h"

#import "FLAnimatedImage.h"

@implementation GifDemoViewController
{
    NSURL *_url;
    
    NSData *_gifData;
    
    FLAnimatedImage *_gifImage;
    
    CicleProgressAnimationView *_progressView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//     https://github.com/Flipboard/FLAnimatedImage
    
    [self createAnimateProgressView];
    
    [[SDWebImageManager sharedManager].imageCache clearDiskOnCompletion:^{
        
        NSLog(@"清理图片缓存成功"); // 测试需求
        
        [self downloadGifAndShow];
    }];
}

- (void)downloadGifAndShow
{
    _url = [NSURL URLWithString:@"https://upload.wikimedia.org/wikipedia/commons/2/2c/Rotating_earth_%28large%29.gif"];
    
    NSString *path = [[[SDWebImageManager sharedManager] imageCache] defaultCachePathForKey:_url.absoluteString];
    
    _gifData = [NSData dataWithContentsOfFile:path];
    
    if (_gifData) {
        
        [self createGifImage];
        
        NSLog(@"设置图片");
        
    } else {
        
        NSLog(@"正在下载");
        
        [SDWebImageDownloader.sharedDownloader downloadImageWithURL:_url options:SDWebImageDownloaderLowPriority progress:^(NSInteger receivedSize, NSInteger expectedSize) {
             dispatch_async(dispatch_get_main_queue(), ^{
                 CGFloat pecent = fabs((CGFloat)receivedSize/(CGFloat)expectedSize);
                 NSLog(@"%.2f", pecent);
                 [self->_progressView showWithProgress:pecent];
             });
         } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
             NSLog(@"下载完成");
             
             dispatch_async(dispatch_get_main_queue(), ^{
                 self->_gifData = data;
                 [self createGifImage];
             });
             
             // 缓存数据
             [SDImageCache.sharedImageCache storeImage:image forKey:_url.absoluteString toDisk:YES];
         }];

    }
}

- (void)createGifImage
{
    _gifImage = ({
        FLAnimatedImage *image = [FLAnimatedImage animatedImageWithGIFData:_gifData];
        FLAnimatedImageView *imageView = [[FLAnimatedImageView alloc] init];
        imageView.animatedImage = image;
        imageView.frame = CGRectMake(0, 64, 100, 100);
        [self.view addSubview:imageView];
        
        image;
    });
}

- (void)createAnimateProgressView
{
    CicleProgressAnimationView *progressView = [[CicleProgressAnimationView alloc] initWithFrame:CGRectMake(100, 164, 100, 100)];
    [self.view addSubview:progressView];
    _progressView = progressView;
}

@end
