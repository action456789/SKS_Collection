//
//  ClassModal.m
//  SKS_Collection
//
//  Created by KeSen on 8/11/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import "ClassModal.h"

@implementation ClassModal

- (instancetype)initWithName:(NSString *)name students:(NSArray *)students
{
    if (self = [super init]) {
        _name = name;
        _isOpen= NO;
        
        _students = [NSMutableArray array];
        for (NSString *studentName in students) {
            StudentModal *stu = [StudentModal new];
            stu.name = studentName;
            [_students addObject:stu];
        }
    }
    return self;
}

@end

@implementation StudentModal

@end
