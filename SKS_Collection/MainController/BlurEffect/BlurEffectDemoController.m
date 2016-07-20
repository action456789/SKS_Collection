//
//  BlurEffectDemoController.m
//  SKS_Collection
//
//  Created by KeSen on 7/20/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import "BlurEffectDemoController.h"

@implementation BlurEffectDemoController {
    UIImageView *_imageView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1. 添加 view
    UIImage *girlImg = [UIImage imageNamed:@"girl"];
    _imageView = [[UIImageView alloc] initWithImage:girlImg];
    _imageView.bounds = CGRectMake(0, 0, girlImg.size.width, girlImg.size.height);
    _imageView.center = self.view.center;
    [self.view addSubview:_imageView];
    
    
    // 2. 添加模糊效果
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    effectView.userInteractionEnabled = NO;
    effectView.frame = self.view.bounds;
    effectView.userInteractionEnabled = YES;
    [self.view addSubview:effectView];
    
    
    // 3. 在模糊效果上添加文字
    UILabel *label      = [UILabel new];
    label.font          = [UIFont systemFontOfSize:20.f];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor     = [UIColor colorWithRed:0.329  green:0.329  blue:0.329 alpha:1];
    label.text          = @"我叫你一声，你敢答应吗？";
    [label sizeToFit];
    label.center        = _imageView.center;
    
    
    // 3.3.1 创建子模糊 view
    UIVibrancyEffect *vibrancyEffect = [UIVibrancyEffect effectForBlurEffect:(UIBlurEffect *)effectView.effect];
    UIVisualEffectView *subEffectView = [[UIVisualEffectView alloc] initWithEffect:vibrancyEffect];
    subEffectView.frame = effectView.bounds;
    [subEffectView.contentView addSubview:label];
    
    // 3.3.2 将子模糊 view 添加到 effectview 的 contentView 才能生效
    [effectView.contentView addSubview:subEffectView];
}

@end
