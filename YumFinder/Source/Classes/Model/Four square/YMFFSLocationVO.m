//
//  YMFFSLocationVO.m
//  YumFinder
//
//  Created by Summer Green on 9/25/14.
//  Copyright (c) 2014 Nimar Labs. All rights reserved.
//

#import "YMFFSLocationVO.h"

@implementation YMFFSLocationVO

+(instancetype)initWithDictionary:(NSDictionary *)d{
    YMFFSLocationVO *location = [YMFFSLocationVO new];
    
    [location setDistance:[d[fsDISTANCE] unsignedLongValue]];
    [location setLat:d[fsLAT]];
    [location setLng:d[fsLNG]];
    return location;
}
@end
