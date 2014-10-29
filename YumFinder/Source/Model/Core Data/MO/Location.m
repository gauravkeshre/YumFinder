
//
//  Location.m
//  YumFinder
//
//  Created by Green Summer on 10/12/14.
//  Copyright (c) 2014 Nimar Labs. All rights reserved.
//

#import "Location.h"
#import "Venue.h"



@implementation Location

@dynamic distance;
@dynamic lat;
@dynamic lng;
@dynamic venue;

-(void)prepareWithDictionary:(NSDictionary *)d{
    [self setDistance:@([d[fsDISTANCE] unsignedLongValue])];
    [self setLat:d[fsLAT]];
    [self setLng:d[fsLNG]];

}
@end
