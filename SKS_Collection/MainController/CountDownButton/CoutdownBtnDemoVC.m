//
//  CoutdownBtnDemoVCr.m
//  SKS_Collection
//
//  Created by sen.ke on 2017/10/19.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import "CoutdownBtnDemoVC.h"
#import "SKSCountDownButton.h"

@interface CoutdownBtnDemoVC ()
@property (weak, nonatomic) IBOutlet SKSCountDownButton *countdownBtn;

@end

@implementation CoutdownBtnDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.countdownBtn.timeLength = 60;
    self.countdownBtn.clickHandle = ^(SKSCountDownButton *sender) {
        
        NSLog(@"%s", __func__);
        
        [sender startCountDown];
    };
}

@end
