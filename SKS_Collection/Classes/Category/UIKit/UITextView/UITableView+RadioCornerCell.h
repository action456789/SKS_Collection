//
//  UITableView+RadioCornerCell.h
//  RICISmartSwift
//
//  Created by sen.ke on 2017/6/21.
//  Copyright © 2017年 ke sen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (RadioCornerCell)

- (void)setCornerRadio:(CGFloat)radio
                  cell:(UITableViewCell *)cell
           atIndexPath:(NSIndexPath *)indexPath
       selectedBgColor:(UIColor *)selectedBgColor;

@end
