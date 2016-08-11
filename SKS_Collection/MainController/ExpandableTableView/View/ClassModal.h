//
//  ClassModal.h
//  SKS_Collection
//
//  Created by KeSen on 8/11/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import <Foundation/Foundation.h>
@class StudentModal;

@interface ClassModal : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) NSMutableArray<StudentModal *> *students;

@property (nonatomic, assign) BOOL isOpen;

- (instancetype)initWithName:(NSString *)name students:(NSArray *)students;

@end

@interface StudentModal : NSObject

@property (nonatomic, copy) NSString *name;

@end
