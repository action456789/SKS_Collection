//
//  RiciColorPaletteVC.h
//  RICISmartSwift
//
//  Created by sen.ke on 2017/12/14.
//  Copyright © 2017年 ke sen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RiciColorPaletteVC;

@protocol RiciColorPaletteVCDelegate <NSObject>

@optional
- (void)colorPalette:(RiciColorPaletteVC *)colorPalette currentColor:(UIColor *)image;

@end

@interface RiciColorPaletteVC : UIViewController

@property (nonatomic, assign) id <RiciColorPaletteVCDelegate> delegate;

- (UIColor *)currentColor;

@end
