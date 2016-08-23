//
//  NSObject+Utils.m
//  SKS_Collection
//
//  Created by KeSen on 8/23/16.
//  Copyright © 2016 SenKe. All rights reserved.
//

#import "NSObject+Utils.h"
#import <MJExtension/MJExtension.h>
#import <objc/runtime.h>
#import "StaticCellItem.h"

@implementation NSObject (Utils)

+ (instancetype)deepCopyObject:(id)obj
{
    id newObj = [[obj class] new];
    [[obj class] enumerateProperties:^(MJProperty *property, BOOL *stop) {
        id value = [obj valueForKey:property.name];
        [newObj setObject:value forKey:property.name];
    }];
    return newObj;
}

/**
 *  输出对象所有属性与类型
 */
- (void)getPropertyNameAndTypeWithObject:(id)obj
{
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([obj class], &outCount);
    for(i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        const char *propName = property_getName(property);
        if(propName) {
            const char *propType = getPropertyType(property);
            NSString *propertyName = [NSString stringWithCString:propName
                                                        encoding:[NSString defaultCStringEncoding]];
            NSString *propertyType = [NSString stringWithCString:propType
                                                        encoding:[NSString defaultCStringEncoding]];
            
            NSLog(@"%@, %@", propertyName, propertyType);
        }
    }
    free(properties);
}

static const char *getPropertyType(objc_property_t property)
{
    const char *attributes = property_getAttributes(property);
    char buffer[1 + strlen(attributes)];
    strcpy(buffer, attributes);
    char *state = buffer, *attribute;
    while ((attribute = strsep(&state, ",")) != NULL) {
        if (attribute[0] == 'T') {
            if (strlen(attribute) <= 4) {
                break;
            }
            return (const char *)[[NSData dataWithBytes:(attribute + 3) length:strlen(attribute) - 4] bytes];
        }
    }
    return "@";
}

@end
