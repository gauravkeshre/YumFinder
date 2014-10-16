//
//  VenueInstagramMedia.h
//  YumFinder
//
//  Created by Gaurav Keshre on 10/12/14.
//  Copyright (c) 2014 Nimar Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Venue;

@interface VenueInstagramMedia : NSManagedObject

@property (nonatomic, retain) id item;
@property (nonatomic, retain) Venue *venue;

- (void)setMediaArray:(NSArray*)list;
-(NSArray*)mediaArray;
@end
