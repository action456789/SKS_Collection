//
//  GifDemoViewController.m
//  SKS_Collection
//
//  Created by KeSen on 8/17/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import "GifDemoViewController.h"
#import <SDWebImage/SDWebImageManager.h>
#import "CicleProgressView.h"

#import <FLAnimatedImage.h>

@implementation GifDemoViewController
{
    NSURL *_url;
    
    NSData *_gifData;
    
    FLAnimatedImage *_gifImage;
    
    UIView *_progressView;
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
        
        SDWebImageDownloader *downloader = [SDWebImageDownloader sharedDownloader];
        [downloader downloadImageWithURL:_url
                                 options:SDWebImageDownloaderLowPriority
                                progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                    
                                    CGFloat precent = fabs((CGFloat)receivedSize/(CGFloat)expectedSize * 100);
                                    NSLog(@"%.0f%%", precent);
                                    
                                } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
                                    
                                    NSLog(@"下载完成");
                                    
                                    dispatch_async(dispatch_get_main_queue(), ^{
                                        _gifData = data;
                                        _progressView.hidden = YES;
                                        [self createGifImage];
                                    });
                                    
                                    // 缓存数据
                                    [[SDImageCache sharedImageCache] storeImage:image
                                                           recalculateFromImage:NO
                                                                      imageData:data
                                                                         forKey:_url.absoluteString
                                                                         toDisk:YES];
                                    
                                   
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
    CicleProgressView *prgressView = [[CicleProgressView alloc] initWithFrame:CGRectMake(100, 64, 100, 100)];
    prgressView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:prgressView];
    
    prgressView.progress = 1.f;
    
}

@end
