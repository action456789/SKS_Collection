//
//  MetaDataManager.h
//  SKS_Collection
//
//  Created by KeSen on 9/8/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CityCounty.h"
#import "Singleton.h"

@interface MetaDataManager : NSObject
singleton_interface(MetaDataManager);

@property (nonatomic, strong) NSArray<CityA2ZItem *>* modalDatas; // 所有模型数据
@property (nonatomic, strong) NSArray<CityDistrict *>* districts; // 所有的市
@property (nonatomic, strong) NSArray<CityCounty *>* counties; // 所有的县

@end
