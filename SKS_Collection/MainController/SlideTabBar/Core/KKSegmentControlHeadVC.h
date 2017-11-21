//
//  KKSegmentControlHeadVC.h
//  SKS_Collection
//
//  Created by sen.ke on 2017/11/21.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KKSlideTabBarBaseLayout;
@class KKSegmentControlHeadVC;

@protocol KKSegmentControlHeadVCDelegate <NSObject>
@optional
- (void)segmentControlHeadVC:(KKSegmentControlHeadVC *)vc itemMoreClicked:(UIButton *)itemMore;
@end

@interface KKSegmentControlHeadVC : UIViewController

@property (nonatomic, assign) id <KKSegmentControlHeadVCDelegate> delegate;

- (instancetype)initWithItemTitles:(NSMutableArray *)itemTitles
                            layout:(KKSlideTabBarBaseLayout *)layout;

@end
