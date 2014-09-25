//
//  YMFFSVenueCategoryVO.h
//  YumFinder
//
//  Created by Gaurav Keshre on 9/25/14.
//  Copyright (c) 2014 Nimar Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YMFBaseVO.h"
@interface YMFFSVenueCategoryVO : YMFBaseVO

@property BOOL isPrimary;
@property(nonatomic, strong)NSString *pluralName;
@property(nonatomic, strong)NSString *shortName;

/*
 * image info
 */
@property(nonatomic, strong)NSString *prefix;
@property(nonatomic, strong)NSString *suffix;

-(NSString *)iconURLWithSize:(CGFloat)size;

@end
