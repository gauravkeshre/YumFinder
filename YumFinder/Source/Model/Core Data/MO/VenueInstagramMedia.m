//
//  VenueInstagramMedia.m
//  YumFinder
//
//  Created by Green Summer on 10/12/14.
//  Copyright (c) 2014 Nimar Labs. All rights reserved.
//

#import "VenueInstagramMedia.h"
#import "Venue.h"


@implementation VenueInstagramMedia

@dynamic item;
@dynamic venue;

-(void)setMediaArray:(NSArray*)list{
    self.item = [NSKeyedArchiver archivedDataWithRootObject:list];
}

-(NSArray*)mediaArray{
    return [NSKeyedUnarchiver unarchiveObjectWithData:self.item];
}
@end
