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

@interface ExpandableViewController()<UITableViewDelegate, UITableViewDataSource, HeaderViewDelegate>

@end

@implementation ExpandableViewController
{
    UITableView *_tableView;
    
    NSArray<NSString *> *_classesName;
    NSArray<NSArray<NSString *> *>* _students;
    
    NSArray<ClassModal *> *_dataArray;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self createSubvies];
    
    [self initData];
}

- (void)createSubvies
{
    _tableView = ({
        CGRect frame = CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64);
        UITableView *tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
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
    
    _classesName = @[@"中单班", @"打野班", @"上单班"];
    
    _students = @[ @[@"妖姬", @"鱼人", @"剑豪"],
                    @[@"盲僧", @"赵信", @"狼人", @"蝎子", @"人马", @"酒桶"],
                    @[@"德玛", @"瑞文", @"诺克", @"鳄鱼", @"刀妹", @"蛮王", @"贾克斯"]];
    
    
    ClassModal *modal0 = [[ClassModal alloc] initWithName:_classesName[0] students:_students[0]];
    ClassModal *modal1 = [[ClassModal alloc] initWithName:_classesName[1] students:_students[1]];
    ClassModal *modal2 = [[ClassModal alloc] initWithName:_classesName[2] students:_students[2]];
    
    _dataArray = @[modal0, modal1, modal2];
    
    [_tableView reloadData];
}

#pragma mark - tableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArray.count;
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
    
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

#pragma mark - HeaderViewDelegate

- (void)headerViewDidClicked:(HeaderView *)headerView withSection:(NSInteger)section
{
    ClassModal *model = _dataArray[section];
    
    if (model.isOpen) {
        
        model.isOpen = NO;
        
        NSMutableArray *indexPaths = [NSMutableArray array];
        for (int i = 0; i < model.students.count; i++) {
            [indexPaths addObject:[NSIndexPath indexPathForItem:i inSection:section]];
        }
        [_tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
    
    } else {
        
        model.isOpen = YES;
        
        NSMutableArray *indexPaths = [NSMutableArray array];
        for (int i = 0; i < model.students.count; i++) {
            [indexPaths addObject:[NSIndexPath indexPathForItem:i inSection:section]];
        }
        [_tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
    }
}

@end
