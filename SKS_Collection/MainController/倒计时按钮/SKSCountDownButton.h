//
//  SKSCountDownButton.h
//  KsCollection
//
//  Created by KeSen on 6/28/16.
//  Copyright © 2016 KeSen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SKSCountDownButton;

/** fix bug:
 * 注意：如果 Button 的类型不是 UIButtonTypeCustomer，会出现闪烁的效果
 * Button 由 xib 创建时，设置 Type 为 Custom 即可解决闪烁问题
 * 参见：http://blog.csdn.net/chenyblog/article/details/49795645
 **/

@interface SKSCountDownButton : UIButton

typedef void (^TouchUpInsideBlock)(SKSCountDownButton *sender);

- (instancetype)initWithTimeLenth:(NSTimeInterval)timeLenth clickdHandle:(TouchUpInsideBlock)handle;

- (void)startCountDown;

@property (nonatomic, assign) NSTimeInterval timeLength;

@property (nonatomic, copy) TouchUpInsideBlock clickHandle;

@end
