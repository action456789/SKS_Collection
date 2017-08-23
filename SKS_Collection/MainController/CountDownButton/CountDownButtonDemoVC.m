//
//  CountDownButtonDemoVC.m
//  SKS_Collection
//
//  Created by KeSen on 6/28/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import "CountDownButtonDemoVC.h"
#import "SKSCountDownButton.h"

@implementation CountDownButtonDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SKSCountDownButton *btn = [[SKSCountDownButton alloc] initWithTimeLenth:11 clickdHandle:^(SKSCountDownButton *sender) {
        NSLog(@"%s, %@", __func__, btn);
    }];
    
    btn.frame = CGRectMake(0, 0, 200, 40);
    [btn setTitle:@"我是按钮" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    btn.center = self.view.center;
    [self.view addSubview:btn];
}


@end
