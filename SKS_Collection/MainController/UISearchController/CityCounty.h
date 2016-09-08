//
//  CityEntity.h
//  SKS_Collection
//
//  Created by KeSen on 9/8/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MJExtension/MJExtension.h>

@interface CityA2ZItem : NSObject // 城市A到Z的分组

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSArray *cities;

@end


@interface CityDistrict : NSObject // 市/区

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSArray *districts;

@end


@interface CityCounty : NSObject // 县

@property (nonatomic, strong) NSString *name;

@end