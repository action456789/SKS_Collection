//
//  SAMKeychainDemoViewController.m
//  SKS_Collection
//
//  Created by KeSen on 2016/11/3.
//  Copyright © 2016年 SenKe. All rights reserved.
//

#import "SAMKeychainDemoViewController.h"

#import "SAMKeychainQuery.h"

#import <FMDB/FMDB.h>
#import <SAMKeychain/SAMKeychain.h>

@interface SAMKeychainDemoViewController ()

@property (nonatomic, strong) FMDatabaseQueue * database;
@property (atomic, strong) NSMutableDictionary * addressList;

@end

@implementation SAMKeychainDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *bundleId = [[NSBundle mainBundle] bundleIdentifier];

    NSError *error = nil;
    [SAMKeychain setPassword:@"12345678" forService:bundleId account:@"account1" error:&error];
    
    if ([error code] == errSecSuccess) {
        NSLog(@"存储 account1 密码_成功");
    }else if ([error code] == errSecItemNotFound) {
        NSLog(@"存储 account1 密码_失败 errSecItemNotFound");
    }else {
        NSLog(@"存储 account1 密码_失败 %@",[error localizedDescription]);
    }
    
    NSError *error2 = nil;
    SAMKeychainQuery *query = [[SAMKeychainQuery alloc] init];
    query.service = @"bundleId";
    query.account = @"account1";
    [query fetch:&error2];
    
    if ([error2 code] == errSecItemNotFound) {
        NSLog(@"Password not found");
    } else if (error2 != nil) {
        NSLog(@"Some other error occurred: %@", [error localizedDescription]);
    } else {
        NSLog(@"%@", query.password);
    }
}


@end
