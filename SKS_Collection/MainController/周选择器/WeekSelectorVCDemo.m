//
//  WeekSelectorVCDemo.m
//  SKS_Collection
//
//  Created by sen.ke on 2017/10/19.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import "WeekSelectorVCDemo.h"

#import "KKWeekSelectorView.h"

@interface WeekSelectorVCDemo () <WeekSelectorViewDelegate>

@property (weak, nonatomic) IBOutlet KKWeekSelectorView *weekSelector;

@end

@implementation WeekSelectorVCDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.weekSelector.delegate = self;
}

- (void)weekSelectorView:(UIView *)view didSelectedDays:(NSArray<KKDay *> *)days {
    NSLog(@"%@", days);
}


@end
