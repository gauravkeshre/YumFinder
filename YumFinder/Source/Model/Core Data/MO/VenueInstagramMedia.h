//
//  VenueInstagramMedia.h
//  YumFinder
//
//  Created by Green Summer on 10/12/14.
//  Copyright (c) 2014 Nimar Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#include "NLS_BaseManagedObject.h"
@class Venue;

@interface VenueInstagramMedia : NLS_BaseManagedObject

@property (nonatomic, retain) id item;
@property (nonatomic, retain) Venue *venue;

- (void)setMediaArray:(NSArray*)list;

-(NSArray*)mediaArray;

@end
