//
//  ListCell.m
//  SKS_Collection
//
//  Created by KeSen on 7/13/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import "ListCell.h"
#import <POP.h>

@implementation ListCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    [super setHighlighted:highlighted animated:animated];
    
    if (self.highlighted) {
        POPBasicAnimation *scaleAnim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewScaleXY];
        scaleAnim.duration = 0.2f;
        scaleAnim.toValue = [NSValue valueWithCGPoint:CGPointMake(0.95, 0.95)];
        [self.textLabel pop_addAnimation:scaleAnim forKey:@"scaleAnimation"];
    } else {
        POPSpringAnimation *scaleAnim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
        scaleAnim.toValue = [NSValue valueWithCGPoint:CGPointMake(1, 1)];
        scaleAnim.velocity = [NSValue valueWithCGPoint:CGPointMake(2, 2)];
        scaleAnim.springBounciness = 20.f;
        [self.textLabel pop_addAnimation:scaleAnim forKey:@"scaleAnimation"];
    }
}

@end
