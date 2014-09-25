//
//  YMFFSRestaurantVO.m
//  YumFinder
//
//  Created by Gaurav Keshre on 9/25/14.
//  Copyright (c) 2014 Nimar Labs. All rights reserved.
//

#import "YMFFSRestaurantVO.h"
#import "YMFFSAddressVO.h"
#import "YMFFSLocationVO.h"
#import "YMFFSVenueCategoryVO.h"

@implementation YMFFSRestaurantVO
/*
 "stats":{},
 
 "verified":false,
 "id":"4a5e00d9f964a520e2bd1fe3",
 
 */
+(instancetype)initWithDictionary:(NSDictionary *)d{
    YMFFSRestaurantVO *rest = [YMFFSRestaurantVO new];

    [rest setHasMenu:[d[fsHASMENU] boolValue]];
    
    [rest setVenueID:d[fsID]];
    [rest setVenueName:d[fsNAME]];
    [rest setSpecials:d[fsSPECIALS]];
    [rest setReferralId:d[fsREFERRALID]];
    
    [rest setSummaryHereNow: d[fsHERENOW][fsSUMMARY]];
    [rest setGroupsHereNow:d[fsHERENOW][fsGROUPS]];
    [rest setCountHereNow:[d[fsHERENOW][fsCOUNT] unsignedLongValue]];
    
    /*
     * Location
     */
    [rest setLocation:[YMFFSLocationVO initWithDictionary:d[fsLOCATION]]];
    
    
    /*
     * Address
     */
    [rest setAddress:[YMFFSAddressVO initWithDictionary:d[fsLOCATION]]];

    
    /*
     * Categories
     */
    if(d[fsCATEGORIES] && [d[fsCATEGORIES] count]>0){
        NSMutableArray *_categories = [[NSMutableArray alloc]initWithCapacity:[d[fsCATEGORIES] count]];
        for (NSInteger i=0; i<_categories.count; i++) {
            
            YMFFSVenueCategoryVO *aCategory = [YMFFSVenueCategoryVO initWithDictionary:d[fsCATEGORIES][i]];
            [_categories addObject:aCategory];
        }
        rest.categories = _categories;
    }
    return rest;
}

@end
