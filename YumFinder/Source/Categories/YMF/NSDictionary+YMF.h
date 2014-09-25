//
//  NSDictionary+YMF.h
//  YumFinder
//
//  Created by Gaurav Keshre on 9/25/14.
//  Copyright (c) 2014 Nimar Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (YMF)

/*
 * External API
 */

+(instancetype)foursquarParamsWithQuery:(NSString *)query andLL:(NSString *)latLng;

-(NSString *)stringWithCommaSeperatedLatLong;
@end
