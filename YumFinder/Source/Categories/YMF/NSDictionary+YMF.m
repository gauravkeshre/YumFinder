//
//  NSDictionary+YMF.m
//  YumFinder
//
//  Created by Gaurav Keshre on 9/25/14.
//  Copyright (c) 2014 Nimar Labs. All rights reserved.
//

#import "NSDictionary+YMF.h"

@implementation NSDictionary (YMF)

-(NSString *)stringWithCommaSeperatedLatLong{
    if ([self.allKeys containsObject:@"lat"] && [self.allKeys containsObject:@"lng"]) {
        
        return [NSString stringWithFormat:@"%@,%@", self[@"lat"], self[@"lng"]];
    }
    return nil;
}

+(instancetype)foursquarParamsWithQuery:(NSString *)query andLL:(NSString *)latLng{
    return  @{
    @"client_id":FSClientID,
    @"client_secret":FSClientSecret,
    @"query":query,
    @"ll":latLng,
    @"m":@"foursquare",
    @"v":@"20140806"
    };
}
@end
