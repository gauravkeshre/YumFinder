//
//  YMFBaseVO.m
//  YumFinder
//
//  Created by Summer Green on 9/25/14.
//  Copyright (c) 2014 Nimar Labs. All rights reserved.
//

#import "YMFBaseVO.h"
#import <objc/runtime.h>
@implementation YMFBaseVO

+(instancetype)initWithDictionary:(NSDictionary *)d{
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

-(NSString *)description{
    NSMutableString *str = [[NSMutableString alloc]init];
    [str appendFormat:@"Class Name: %@", NSStringFromClass([self class])];
    [str appendString:@"\n------------\n"];
    @autoreleasepool {
        unsigned int numberOfProperties = 0;
        objc_property_t *propertyArray = class_copyPropertyList([self class], &numberOfProperties);
        for (NSUInteger i = 0; i < numberOfProperties; i++) {
            objc_property_t property = propertyArray[i];
            NSString *name = [[NSString alloc] initWithUTF8String:property_getName(property)];
//            NSLog(@"Property %@ Value: %@", name, [self valueForKey:name]);
            [str appendFormat:@"%@ : %@ \n", name, [self valueForKey:name]];
        }
        free(propertyArray);
    }
    return str;
    
}
@end
