//
//  NLSFSVenueVO.m
//  Restaurage
//
//  Created by Summer Green on 9/19/14.
//  Copyright (c) 2014 Nimar Labs Solutions. All rights reserved.
//

#import "NLSFSVenueVO.h"
#import "NLSLocationVO.h"
@implementation NLSFSVenueVO

-(NSString *)iconImageForCategoryAtIndex:(NSUInteger)index withSize:(CGFloat)size{
    if (index>=self.categories.count) {
        return nil;
    }
    NSUInteger s = 32;
    if (size<32) {
        s=32;
    }else if (size>88){
        s=88;
    }
    NSDictionary * iconDictionary = self.categories[index][@"icon"];
    return [NSString stringWithFormat:@"%@%@.%@", iconDictionary[@"prefix"], NSStringFromIntOrLong(size), iconDictionary[@"suffix"]];
}
@end
