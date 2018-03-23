//
//  UIImage+CoreImage.h
//  RICISmartSwift
//
//  Created by sen.ke on 2017/12/21.
//  Copyright © 2017年 ke sen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CoreImage)

/**
 *  根据CIImage生成指定大小的UIImage
 *  解决 UIImage(ciImage: outputImage) 生成UIImage不清晰的问题 
 *  @param image CIImage
 *  @param imageSize  图片尺寸
 *
 *  @return 生成的高清的UIImage
 */
+ (UIImage *)kk_imageFormCIImage:(CIImage *)image imageSize:(CGSize)imageSize;

@end
