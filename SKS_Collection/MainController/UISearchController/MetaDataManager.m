//
//  MetaDataManager.m
//  SKS_Collection
//
//  Created by KeSen on 9/8/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import "MetaDataManager.h"
@class MetaDataManager;

@implementation MetaDataManager
singleton_implementation(MetaDataManager);

- (NSArray<CityA2ZItem *> *)modalDatas
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Cities.plist" ofType:nil];
    NSArray *dataArray = [NSArray arrayWithContentsOfFile:path].mutableCopy;
    return [CityA2ZItem objectArrayWithKeyValuesArray:dataArray];
}

- (NSArray<CityDistrict *> *)districts
{
    NSMutableArray *array = [NSMutableArray array];
    
    for (CityA2ZItem *item in self.modalDatas) {
        for (CityDistrict *dictricts in item.cities) {
            [array addObject:dictricts];
        }
    }
    return array;
}

- (NSArray<CityCounty *> *)counties
{
    NSMutableArray *array = [NSMutableArray array];
    
    for (CityDistrict *dictricts in self.districts) {
        for (CityCounty *county in dictricts.districts) {
            [array addObject:county];
        }
    }
    return array;
}

@end
