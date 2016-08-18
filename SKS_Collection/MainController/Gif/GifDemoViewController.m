//
//  GifDemoViewController.m
//  SKS_Collection
//
//  Created by KeSen on 8/17/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import "GifDemoViewController.h"
#import <SDWebImage/SDWebImageManager.h>

#import <FLAnimatedImage.h>

@implementation GifDemoViewController
{
    NSURL *_url;
    FLAnimatedImage *_gifImage;
    NSData *_gifData;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // https://github.com/Flipboard/FLAnimatedImage
    
    _gifImage = ({
        FLAnimatedImage *image = [FLAnimatedImage animatedImageWithGIFData:_gifData];
        FLAnimatedImageView *imageView = [[FLAnimatedImageView alloc] init];
        imageView.animatedImage = image;
        imageView.frame = CGRectMake(0.0, 64.0, 100.0, 100.0);
        [self.view addSubview:imageView];
        
        image;
    });
    
    [[SDWebImageManager sharedManager].imageCache clearDiskOnCompletion:^{
        NSLog(@"清理图片缓存成功");
        [self downloadGifAndShow];
    }];
}

- (void)downloadGifAndShow
{
    _url = [NSURL URLWithString:@"https://upload.wikimedia.org/wikipedia/commons/2/2c/Rotating_earth_%28large%29.gif"];
    
    NSString *path = [[[SDWebImageManager sharedManager] imageCache] defaultCachePathForKey:_url.absoluteString];
    
    _gifData = [NSData dataWithContentsOfFile:path];
    
    if (_gifData) {
        
        [self addGifImage];
        
        NSLog(@"设置图片");
        
    } else {
        
        NSLog(@"正在下载");
        
        SDWebImageDownloader *downloader = [SDWebImageDownloader sharedDownloader];
        [downloader downloadImageWithURL:_url
                                 options:SDWebImageDownloaderContinueInBackground
                                progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                    
                                    NSLog(@"%.f%%", (CGFloat)receivedSize/(CGFloat)expectedSize * 100);
                                    
                                } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
                                    
                                    NSLog(@"下载完成");
                                    
                                    dispatch_async(dispatch_get_main_queue(), ^{
                                        _gifData = data;
                                        [self addGifImage];
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

- (void)addGifImage
{
    _gifImage = ({
        FLAnimatedImage *image = [FLAnimatedImage animatedImageWithGIFData:_gifData];
        FLAnimatedImageView *imageView = [[FLAnimatedImageView alloc] init];
        imageView.animatedImage = image;
        imageView.frame = CGRectMake(0.0, 64.0, 100.0, 100.0);
        [self.view addSubview:imageView];
        
        image;
    });
}

@end
