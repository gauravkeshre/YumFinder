//
//  NSMutableDictionary+Additions.h
//  DiamondOffshore
//
//  Created by Summer Green on 8/19/14.
//  Copyright (c) 2014 Nimar Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (Additions)
-(void)setObjectOrNil:(id)anObject forKey:(id<NSCopying>)aKey;
@end
