//
//  EjectShrinkBtnsDemoVC.m
//  SKS_Collection
//
//  Created by sen.ke on 2017/4/18.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import "EjectShrinkBtnsDemoVC.h"
#import "UPEjectShrinkBtnsView.h"
#import "CommonMacro.h"

@interface EjectShrinkBtnsDemoVC () <UPEjectShrinkBtnsViewDelegate>
@property (nonatomic, strong) UPEjectShrinkBtnsView *ejectShrinkBtnsView;
@end

@implementation EjectShrinkBtnsDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.ejectShrinkBtnsView];
}

- (UPEjectShrinkBtnsView *)ejectShrinkBtnsView {
    if (_ejectShrinkBtnsView == nil) {
        CGFloat ejectY = self.view.center.y;
        _ejectShrinkBtnsView = [[UPEjectShrinkBtnsView alloc] initWithFrame:CGRectMake(5, ejectY, kScreenWidth, 50)];
        _ejectShrinkBtnsView.animateOption = EjectShrikAnimationTypeKeyFrame;
        _ejectShrinkBtnsView.delegate = self;
    }
    return _ejectShrinkBtnsView;
}

- (void)ejectShrinkBtnsView:(UPEjectShrinkBtnsView *)view didClickedButtonAtIndex:(NSInteger)index {
    
    if (index == 1) { // 股价预测

    } else if (index == 2) { // 最优策略
        
    } else if (index == 3) { // 优品评测
        
    }
}

@end
