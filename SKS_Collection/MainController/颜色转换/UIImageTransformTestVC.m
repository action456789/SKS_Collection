//
//  UIImageTransformTestVC.m
//  SKS_Collection
//
//  Created by ke sen. on 2018/5/14.
//  Copyright © 2018年 SenKe. All rights reserved.
//

#import "UIImageTransformTestVC.h"
#import "UIImage+Modify.h"

@interface UIImageTransformTestVC ()

@property (weak, nonatomic) IBOutlet UIImageView *sourceImageView;
@property (weak, nonatomic) IBOutlet UIImageView *modifyedImageView;

@end

@implementation UIImageTransformTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
 
//    UIImage *sourceImage = _sourceImageView.image;
//    unsigned char * data = sourceImage.kk_toBytes;
//    _modifyedImageView.image = [UIImage kk_fromBytes:data originImageW:sourceImage.size.width originImageH:sourceImage.size.height];
}
@end
