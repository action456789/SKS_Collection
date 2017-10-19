//
//  TipsViewDemoVC.m
//  SKS_Collection
//
//  Created by sen.ke on 2017/10/19.
//  Copyright © 2017年 SenKe. All rights reserved.
//

#import "TipsViewDemoVC.h"
#import "KKTipsView.h"
#import "CommonMacro.h"

@interface TipsViewDemoVC ()

@end

@implementation TipsViewDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (IBAction)showTips1:(id)sender {
    UIView *contetView = (UIView *)[[NSBundle mainBundle] loadNibNamed:@"MailRegisterSuccess" owner:nil options:nil].lastObject;
    
    KKTipsView *tipsView = [KKTipsView new];
    tipsView.showType = KKTipsViewShowTypeCenter;
    tipsView.contentView = contetView;
    tipsView.contentViewSize = CGSizeMake(300, 200);
    if (tipsView.isAnimating) {
        return;
    }
    [tipsView showInView:nil animatable:YES];
}

- (IBAction)showTips2:(id)sender {
    UIView *contetView = (UIView *)[[NSBundle mainBundle] loadNibNamed:@"EditMenuView" owner:nil options:nil].lastObject;
    
    KKTipsView *tipsView = [KKTipsView new];
    tipsView.showType = KKTipsViewShowTypeFromBottom;
    tipsView.contentView = contetView;
    tipsView.contentViewSize = CGSizeMake(kScreenWidth, 50);
    tipsView.showingMask = NO;
    tipsView.isMaskUserInteractive = NO;
    
    if (tipsView.isAnimating) {
        return;
    }
    [tipsView showInView:self.view animatable:YES];
    
}

@end
