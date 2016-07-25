//
//  KK_DiskCache.m
//  KsCollection
//
//  Created by KeSen on 16/4/18.
//  Copyright © 2016年 KeSen. All rights reserved.
//

#import "DiskCacheSqlLite.h"
#import <FMDB/FMDB.h>
#import "NSFileManager+File.h"
#import "NSString+Code.h"

@interface DiskCacheSqlLite()
{
    NSCache *_memoryCache;
    NSString *_dbFilePath;
    FMDatabase *_db;
    FMDatabaseQueue *_dbQueue;
}
@end

#define DATABASE_KEY @"com.kesen.www"

@implementation DiskCacheSqlLite

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _dbQueue = [FMDatabaseQueue databaseQueueWithPath:_dbFilePath];
        _memoryCache = [[NSCache alloc] init];
        _isTableEncrypt = NO;
        
        [self _createDbFile];
        [self _openDb];
    }
    return self;
}

- (void)dealloc {
    if (_db) {
        [_db close];
    }
}

#pragma mark -init

- (void)_createDbFile
{
    [NSFileManager createFoldWithDirectory:kCacheDirectory withFoldName:@"DiskCacheSqlLite" success:^(NSString *newFoldDirectory) {
        [NSFileManager createFileWithDirectory:newFoldDirectory withName:@"Cache.db" success:^(NSString *newFilePath) {
            _dbFilePath = newFilePath;
        } failure:nil];
    } failure:nil];
}

- (void)_openDb
{
    [_dbQueue inDatabase:^(FMDatabase *db) {
        _db = [FMDatabase databaseWithPath:_dbFilePath];
        if ([_db open]) {
            if (_isTableEncrypt) {
                [_db setKey:DATABASE_KEY];
            }
            BOOL result = [_db executeUpdate:@"create table if not exists cache_table (key text PRIMARY KEY, value blob, create_date text, update_date text)"];
            NSLog(@"DiskCacheSqlLite:creare db %@",result?@"success":@"fail");
        } else {
            NSLog(@"DiskCacheSqlLite:Could not open db.");
        }
        [_db setShouldCacheStatements:YES];
    }];
}

- (NSString *)_nowDateString
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss zzz";
    
    return [fmt stringFromDate:[NSDate date]];
}

#pragma mark - add, delete, update, select

- (void)dbAddItemWithKey:(NSString *)key value:(id<NSCoding>)object
{
    if (!_db) return;
    
    NSString *encodeKey = [key encodedString];
    [_memoryCache setObject:object forKey:encodeKey];
    
    [_dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:object];
        BOOL result = [_db executeUpdate:@"insert into cache_table (key, value, create_date) values (?, ?, ?)", encodeKey, data, [self _nowDateString]];
        *rollback = !result;
    }];
}

- (id<NSCoding>)dbGetItemWithKey:(NSString *)key
{
    NSString *encodeKey = [key encodedString];
    id data = [_memoryCache objectForKey:encodeKey];
    
    if (data) {
        return data;
    } else {
        FMResultSet *rs = [_db executeQuery:@"select value from cache_table where key = ?", encodeKey];
        while ([rs next]) {
            data = [rs dataForColumn:@"value"];
            break;
        }
        [rs close];
        
        id object = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        return object;
    }
}

- (void)dbUpdateItemWithKey:(NSString *)key value:(id<NSCoding>)object
{
    if (!_db) return;
    
    NSString *encodeKey = [key encodedString];
    [_memoryCache setObject:object forKey:encodeKey];
    
    [_dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:object];
        BOOL result = [_db executeUpdate:@"update cache_table set value = ?, update_date = ? where key = ?", data, [self _nowDateString], encodeKey];
        *rollback = !result;
    }];
}

- (void)dbDeleteItemWithKey:(NSString *)key
{
    if (!_db) return;
    
    NSString *encodeKey = [key encodedString];
    [_memoryCache removeObjectForKey:encodeKey];
    
    [_dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        BOOL result = [_db executeUpdate:@"delete from cache_table where key = ?", encodeKey];
        *rollback = !result;
    }];
}

- (NSDictionary *)dbAllKeysAndValues
{
    if (!_db) return nil;
    NSMutableDictionary *dict = nil;

    NSString *sql = @"SELECT key, value FROM manifest";
    FMResultSet *rs = [_db  executeQuery:sql];
    while ([rs next]) {
        NSString *key = [rs stringForColumn:@"key"];
        NSData *data = [rs dataForColumn:@"value"];
        [dict setObject:data forKey:key];
    }
    return dict;
}

#pragma mark - other

// dbQueue多线程测试
// 当执行特别多条sql（比如10000条）语句时，使用 dbQueue 会比不使用 dbQueue 高出一个数量级
- (void)test_BatabaseQueue
{
    
    __block NSMutableDictionary *dict = nil;
    
    dispatch_time_t now = dispatch_time(DISPATCH_TIME_NOW, 0);

    [_dbQueue inDatabase:^(FMDatabase *db) {
        NSString *sql = @"SELECT key, value FROM cache_table";

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
    NSString *sql = @"SELECT key, value FROM cache_table";
    while (i) {
        [_db  executeQuery:sql];
        i--;
    }

    dispatch_time_t afert1 = dispatch_time(DISPATCH_TIME_NOW, 0);
    
    NSLog(@"time cost2: %.2llu\n, %@", afert1-now1, dict);
}

@end
