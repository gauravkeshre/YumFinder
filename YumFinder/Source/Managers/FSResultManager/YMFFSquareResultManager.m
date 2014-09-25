//
//  YMFFSquareResultManager.m
//  YumFinder
//
//  Created by Gaurav Keshre on 9/25/14.
//  Copyright (c) 2014 Nimar Labs. All rights reserved.
//

#import "YMFFSquareResultManager.h"
#import "NSDictionary+YMF.h"
#import "YMFFSRestaurantVO.h"
#import "YMFFSAddressVO.h"

@implementation YMFFSquareResultManager

-(void)parseResultFromArray:(NSArray *)array onSuccess:(YMF_SuccessCallback)callback{
    
    NSDictionary *d1 = [array firstObject];
    NSLog(@"%@", d1);
    
    __block NSMutableArray *mArr = [[NSMutableArray alloc]init];
    
    [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
        [mArr addObject:[YMFFSRestaurantVO initWithDictionary:obj]];
    }];
}
@end
