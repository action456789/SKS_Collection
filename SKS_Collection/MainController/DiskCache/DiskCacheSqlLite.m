//
//  KK_DiskCache.m
//  KsCollection
//
//  Created by KeSen on 16/4/18.
//  Copyright © 2016年 KeSen. All rights reserved.
//

#import "DiskCacheSqlLite.h"
#import <FMDB/FMDB.h>

@interface DiskCacheSqlLite()

@property (nonatomic, copy) NSString *dbPath;
@property (nonatomic, strong) FMDatabase *db;
@property (nonatomic, strong) FMDatabaseQueue *dbQueue;

@end

#define DATABASE_KEY @"com.kesen.www"

@implementation DiskCacheSqlLite

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSLog(@"%@", self.dbPath);
    }
    return self;
}

- (void)dealloc {
    if (_db) {
        [_db close];
    }
}

- (void)deleteDBFile {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:self.dbPath error:nil];
}

- (NSString *)dbPath {
    if (!_dbPath) {
        NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        NSString *dbFileName = [[[NSBundle mainBundle] bundleIdentifier] stringByAppendingPathExtension:@"db"];
        _dbPath = [caches stringByAppendingPathComponent:dbFileName];
    }
    return _dbPath;
}

// open db
- (FMDatabase *)db {
    if (!_db) {
        _db = [FMDatabase databaseWithPath:self.dbPath];
        if ([_db open]) {
            // 加密数据库文件
            [_db setKey:DATABASE_KEY];
            BOOL result = [_db executeUpdate:@"create table if not exists manifest (key text, value blob)"];
            NSLog(@"creare %@",result?@"success":@"fail");
        } else {
            NSLog(@"Could not open db.");
            return nil;
        }
        
        [_db setShouldCacheStatements:YES];
    }
    return _db;
}

- (FMDatabaseQueue *)dbQueue {
    if (!_dbQueue) {
        _dbQueue = [FMDatabaseQueue databaseQueueWithPath:self.dbPath];
        [_dbQueue inDatabase:^(FMDatabase *db) {
            [db setKey:DATABASE_KEY];
            BOOL result = [db executeUpdate:@"create table if not exists manifest (key text, value blob)"];
            NSLog(@"creare %@",result?@"success":@"fail");
        }];
    }
    return _dbQueue;
}

- (BOOL)dbAddItemWithKey:(NSString *)key value:(NSData *)value {
    if (!self.db) return NO;
    
    [self.db beginTransaction];
    BOOL result = [self.db executeUpdate:@"insert into manifest (key, value) values (?, ?)", key, value];
    [self.db commit];

    return result;
}

- (NSData *)dbGetItemWithKey:(NSString *)key {
    
    FMResultSet *rs = [self.db  executeQuery:@"select value from manifest where key = ?", key];
    NSData *data = nil;
    while ([rs next]) {
        data = [rs dataForColumn:@"value"];
    }
    [rs close];
    return data;
}

- (BOOL)dbUpdateItemWithKey:(NSString *)key value:(NSData *)data {
    if (!self.db) return NO;
    
    [self.db beginTransaction];
    BOOL result = [self.db executeUpdate:@"update manifest set value = ? where key = ?", data, key];
    [self.db commit];
    
    return result;
}

- (BOOL)dbDeleteItemWithKey:(NSString *)key {
    if (!self.db) return NO;
    
    [self.db beginTransaction];
    BOOL result = [self.db executeUpdate:@"delete from manifest where key = ?", key];
    [self.db commit];
    
    return result;
}

- (NSDictionary *)dbAllKeysAndValues {
    if (!self.db) return nil;
    NSMutableDictionary *dict = nil;

    NSString *sql = @"SELECT key, value FROM manifest";
    FMResultSet *rs = [self.db  executeQuery:sql];
    while ([rs next]) {
        NSString *key = [rs stringForColumn:@"key"];
        NSData *data = [rs dataForColumn:@"value"];
        [dict setObject:data forKey:key];
    }
    return dict;
}

// dbQueue多线程测试
// 当执行特别多条sql（比如10000条）语句时，使用 dbQueue 会比不使用 dbQueue 高出一个数量级
- (void)test_BatabaseQueue {
    
    __block NSMutableDictionary *dict = nil;
    
    dispatch_time_t now = dispatch_time(DISPATCH_TIME_NOW, 0);

    [self.dbQueue inDatabase:^(FMDatabase *db) {
        NSString *sql = @"SELECT key, value FROM manifest";

        int i = 10000;
        while (i) {
            [db  executeQuery:sql];
            i--;
        }
    }];

    dispatch_time_t afert = dispatch_time(DISPATCH_TIME_NOW, 0);

    NSLog(@"time cost1: %.2llu\n, %@", afert-now, dict);

    dispatch_time_t now1 = dispatch_time(DISPATCH_TIME_NOW, 0);

    int i = 10000;
    NSString *sql = @"SELECT key, value FROM manifest";
    while (i) {
        [self.db  executeQuery:sql];
        i--;
    }

    dispatch_time_t afert1 = dispatch_time(DISPATCH_TIME_NOW, 0);
    
    NSLog(@"time cost2: %.2llu\n, %@", afert1-now1, dict);
}

@end
