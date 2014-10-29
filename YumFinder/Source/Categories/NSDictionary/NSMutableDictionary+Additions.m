//
//  NSMutableDictionary+Additions.m
//  Yumfinder
//
//  Created by Summer Green on 8/19/14.
//  Copyright (c) 2014 Nimar Labs. All rights reserved.
//

#import "NSMutableDictionary+Additions.h"

@implementation NSMutableDictionary (Additions)

-(void)setObjectOrNil:(id)anObject forKey:(id<NSCopying>)aKey{
    if ([anObject isEqual:[NSNull null]] || anObject ==nil) {
        [self setObject:@"" forKey:aKey];
    }
        [self setObject:anObject forKey:aKey];
}
@end
