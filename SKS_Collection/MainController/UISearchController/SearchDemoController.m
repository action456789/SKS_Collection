//
//  SearchDemoController.m
//  SKS_Collection
//
//  Created by KeSen on 9/8/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import "SearchDemoController.h"
#import "CityCounty.h"
#import "MetaDataManager.h"

@interface SearchDemoController ()<UISearchResultsUpdating>

@end

@implementation SearchDemoController
{
    UISearchController *_searchController;
    NSMutableArray<CityCounty *> *_resultArray;
    NSMutableArray *_dataArray;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initData];
    [self createSearchController];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if (_searchController.active) {
        _searchController.active = NO;
        [_searchController.searchBar removeFromSuperview];
    }
}

- (void)initData
{
    _dataArray = [MetaDataManager sharedInstance].districts.mutableCopy;
}

- (void)createSearchController
{
    _searchController = ({
        UISearchController *searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
        searchController.searchResultsUpdater = self;
        searchController.dimsBackgroundDuringPresentation = YES;
        searchController.searchBar.placeholder = @"请输入搜索内容";
        [searchController.searchBar sizeToFit];
        
        self.tableView.tableHeaderView = searchController.searchBar;
        
        searchController;
    });
}

/**
     逻辑运算符 && AND || OR 都可以用
     以……开头 BEGINSWITH
     以……结尾 ENDSWITH
     包含….字符 CONTAINS
     
     用like进行模糊查询
     通配符：*表示任意个字符 ？表示单个字符
     like *a 以a结尾
     like a* 以a开头
     like *a* 包含a字符
     like ?a* 第二个字符为a的字符串
 */

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name CONTAINS %@", searchController.searchBar.text];
    _resultArray = [_dataArray filteredArrayUsingPredicate:predicate].mutableCopy;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}


# pragma mark - tableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _resultArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = _resultArray[indexPath.row].name;
    
    return cell;
}

@end
