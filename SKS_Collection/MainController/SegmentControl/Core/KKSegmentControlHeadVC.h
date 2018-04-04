//
//  KKSegmentControlHeadVC.h
//  SKS_Collection
//
//  Created by sen.ke on 2017/11/21.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonMacro.h"
#import "KKSegmentControlBaseLayout.h"

@class KKSegmentControlHeadVC;

NS_ASSUME_NONNULL_BEGIN

@protocol KKSegmentControlHeadVCDelegate <NSObject>

@optional
- (void)segmentControlHeadVC:(KKSegmentControlHeadVC *)vc itemMoreClicked:(UIButton *)itemMore;

- (void)segmentControlHeadVC:(KKSegmentControlHeadVC *)vc itemChangedFromIndex:(NSUInteger)from toIndex:(NSUInteger)to;

@end

@interface KKSegmentControlHeadVC : UIViewController

@property (nonatomic, assign) id <KKSegmentControlHeadVCDelegate> delegate;

@property (nonatomic, strong, readonly) KKSegmentControlBaseLayout *layout;

- (instancetype)initWithItemTitles:(NSMutableArray *)itemTitles
                            layout:(KKSegmentControlBaseLayout *)layout;

- (void)autoScrollItemsScrollViewFromIndex:(NSUInteger)from
                                   toIndex:(NSUInteger)to
                                   animate:(BOOL)animate;

@end

NS_ASSUME_NONNULL_END
