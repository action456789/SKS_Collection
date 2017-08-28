//
//  UITextField+selectText.h
//  SKS_Collection
//
//  Created by sen.ke on 2017/8/28.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (selectText)

/**
 Set all text selected.
 */
- (void)kk_selectAllText;

/**
 Set text in range selected.
 
 @param range  The range of selected text in a document.
 */
- (void)kk_setSelectedRange:(NSRange)range;

@end
