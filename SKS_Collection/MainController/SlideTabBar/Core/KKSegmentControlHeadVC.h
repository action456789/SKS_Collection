//
//  KKSegmentControlHeadVC.h
//  SKS_Collection
//
//  Created by sen.ke on 2017/11/21.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KKSegmentControlBaseLayout;
@class KKSegmentControlHeadVC;

@protocol KKSegmentControlHeadVCDelegate <NSObject>
@optional
- (void)segmentControlHeadVC:(KKSegmentControlHeadVC *)vc itemMoreClicked:(UIButton *)itemMore;

- (void)segmentControlHeadVC:(KKSegmentControlHeadVC *)vc itemChangedFromIndex:(NSUInteger)from toIndex:(NSUInteger)to;

// 是否显示滑块
- (BOOL)isShowItemLineForSegmentControlHeadVC:(KKSegmentControlHeadVC *)vc;
@end

@interface KKSegmentControlHeadVC : UIViewController

@property (nonatomic, assign) id <KKSegmentControlHeadVCDelegate> delegate;

- (instancetype)initWithItemTitles:(NSMutableArray *)itemTitles
                            layout:(KKSegmentControlBaseLayout *)layout;

- (void)autoScrollItemsScrollViewFromIndex:(NSUInteger)from
                                   toIndex:(NSUInteger)to
                                   animate:(BOOL)animate;

@end
