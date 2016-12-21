//
//  KKSlideTabBarBaseLayout.m
//  SKS_Collection
//
//  Created by KeSen on 2016/12/21.
//  Copyright © 2016年 SenKe. All rights reserved.
//

#import "KKSlideTabBarBaseLayout.h"

@implementation KKSlideTabBarBaseLayout {
    UIView *_superView;
}

# pragma mark - getter

- (instancetype)initWithItemTitles:(NSArray<NSString *> *)itemTitles {
    self = [super init];
    if (self) {
        _itemTitles = itemTitles;
    }
    return self;
}

- (NSMutableArray *)itemStringWidths
{
    if (!_itemStringWidths) {
        _itemStringWidths = [NSMutableArray array];
        NSDictionary *attrs = @{NSFontAttributeName : [UIFont systemFontOfSize:kSTBItemFontSize]};
        for (NSString *title in _itemTitles) {
            CGFloat w = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size.width;
            [_itemStringWidths addObject:@(ceil(w))];
        }
    }
    return _itemStringWidths;
}

- (void)layoutItemsViews:(NSArray *)views {
    
}

- (CGFloat)lineWidthWithIndex:(NSInteger)index {
    return 0;
}

@end
