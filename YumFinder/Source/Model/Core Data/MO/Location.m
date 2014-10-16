
//
//  Location.m
//  YumFinder
//
//  Created by Gaurav Keshre on 10/12/14.
//  Copyright (c) 2014 Nimar Labs. All rights reserved.
//

#import "Location.h"
#import "Venue.h"
#import "YMFFSLocationVO.h"


@implementation Location

@dynamic distance;
@dynamic lat;
@dynamic lng;
@dynamic venue;

-(void)initializeFromObject:(YMFFSLocationVO *)location{
    [self setDistance:@(location.distance)];
    [self setLat:location.lat];
    [self setLng:location.lng];
}
@end
