//
//  AddClickAreaButtonDemeVC.m
//  SKS_Collection
//
//  Created by ke sen. on 2017/1/11.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import "AddClickAreaButtonDemeVC.h"
#import "KKHitTestEdgeInsetsButton.h"

@interface AddClickAreaButtonDemeVC ()

@property (weak, nonatomic) IBOutlet KKHitTestEdgeInsetsButton *button;

@end

@implementation AddClickAreaButtonDemeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 四周增加 100
//    self.buttom.padding = 100;
    
    // 四周增加 30
    self.button.hitTestEdgeInsets = UIEdgeInsetsMake(-30, -30, -30, -30);
}

- (IBAction)buttonClicked:(UIButton *)sender {
    NSLog(@"%s", __func__);
}

@end
