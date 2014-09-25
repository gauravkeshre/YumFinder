//
//  YMFFSVenueCategoryVO.m
//  YumFinder
//
//  Created by Gaurav Keshre on 9/25/14.
//  Copyright (c) 2014 Nimar Labs. All rights reserved.
//

#import "YMFFSVenueCategoryVO.h"

@implementation YMFFSVenueCategoryVO

-(NSString *)iconURLWithSize:(CGFloat)size{
    return [NSString stringWithFormat:@"%@%f%@", self.prefix, size, self.suffix];
}
@end
