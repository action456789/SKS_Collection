//
//  QQListViewController.m
//  SKS_Collection
//
//  Created by KeSen on 8/10/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import "ExpandableViewController.h"
#import "HeaderView.h"
#import "ClassModal.h"
#import "CommonMacro.h"

@interface ExpandableViewController()<UITableViewDelegate, UITableViewDataSource, HeaderViewDelegate>

@end

@implementation ExpandableViewController
{
    UITableView *_tableView;
    
    NSArray<ClassModal *> *_dataArray;
    
    BOOL _isSectionFirstLoad;
    
    HeaderView *_firstHeadView;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initSubvies];
    
    [self initData];
    
    [self firstLoadDataAnimation];
}

- (void)initSubvies
{
    _tableView = ({
        CGRect frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        UITableView *tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.rowHeight = 50;
        tableView.alwaysBounceVertical = YES;
        tableView.showsVerticalScrollIndicator = NO;
        tableView.showsHorizontalScrollIndicator = NO;
        tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        [tableView registerClass:[HeaderView class] forHeaderFooterViewReuseIdentifier:@"headerCell"];
        [self.view addSubview:tableView];
        
        tableView;
    });
}

- (void)initData {
    
    NSArray<NSString *> *classesName = @[@"中单班", @"打野班", @"上单班"];
    
    NSArray<NSArray<NSString *> *>* students = @[ @[@"妖姬", @"鱼人", @"剑豪"],
                                                    @[@"盲僧", @"赵信", @"狼人", @"蝎子", @"人马", @"酒桶"],
                                                    @[@"德玛", @"瑞文", @"诺克", @"鳄鱼", @"刀妹", @"蛮王", @"贾克斯"]];
    
    ClassModal *modal0 = [[ClassModal alloc] initWithName:classesName[0] students:students[0]];
    ClassModal *modal1 = [[ClassModal alloc] initWithName:classesName[1] students:students[1]];
    ClassModal *modal2 = [[ClassModal alloc] initWithName:classesName[2] students:students[2]];
    
    _dataArray = @[modal0, modal1, modal2];
}

#pragma mark - tableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _isSectionFirstLoad ? _dataArray.count : 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray[section].isOpen ? _dataArray[section].students.count : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    ClassModal *class = _dataArray[indexPath.section];
    StudentModal *student = class.students[indexPath.row];
    cell.textLabel.text = student.name;
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    HeaderView *header = [HeaderView headerViewWithTableView:tableView];
    header.classModal = _dataArray[section];
    header.delegate = self;
    header.section = section;
    
    if (section == 0) {
        _firstHeadView = header;
    }
    
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return kHeadViewW;
}

#pragma mark - HeaderViewDelegate

- (void)headerViewDidClicked:(HeaderView *)headerView withSection:(NSInteger)section
{
    ClassModal *model = _dataArray[section];
    
    if (model.isOpen) { // 收起
        
        model.isOpen = NO;
        
        [headerView startAnimationNormal];
        
        NSMutableArray *indexPaths = [NSMutableArray array];
        for (int i = 0; i < model.students.count; i++) {
            [indexPaths addObject:[NSIndexPath indexPathForItem:i inSection:section]];
        }
        [_tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
    
    } else { // 展开
        
        model.isOpen = YES;
        
        [headerView startAnimationExtend];
        
        NSMutableArray *indexPaths = [NSMutableArray array];
        for (int i = 0; i < model.students.count; i++) {
            [indexPaths addObject:[NSIndexPath indexPathForItem:i inSection:section]];
        }
        [_tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
    }
}

#pragma mark - other

- (void)firstLoadDataAnimation
{
    dispatch_async(dispatch_get_main_queue(), ^{ //TODO 为什么不加这个线程代码就没有动画效果呢？
        self->_isSectionFirstLoad = YES;
        
        NSIndexSet *indexSet  = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, _dataArray.count)];
        [self->_tableView insertSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self headerViewDidClicked:self->_firstHeadView withSection:0];
        });
    });
}

@end
