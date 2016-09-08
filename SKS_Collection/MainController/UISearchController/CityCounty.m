//
//  CityEntity.m
//  SKS_Collection
//
//  Created by KeSen on 9/8/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import "CityCounty.h"

@implementation CityA2ZItem

+ (NSDictionary *)objectClassInArray
{
    return @{@"cities" : [CityDistrict class]};
}

@end


@implementation CityDistrict

+ (NSDictionary *)objectClassInArray
{
    return @{@"districts" : [CityCounty class]};
}

@end


@implementation CityCounty

@end



