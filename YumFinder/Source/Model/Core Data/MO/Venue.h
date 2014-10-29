//
//  Venue.h
//  YumFinder
//
//  Created by Green Summer on 10/17/14.
//  Copyright (c) 2014 Nimar Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "NLS_BaseManagedObject.h"

@class Address, Location, VenueCategory, VenueInstagramMedia;

@interface Venue : NLS_BaseManagedObject

@property (nonatomic, retain) NSNumber * checkinsCount;
@property (nonatomic, retain) NSNumber * countHereNow;
@property (nonatomic, retain) NSString * hashTag;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * referralId;
@property (nonatomic, retain) NSNumber * tipCount;
@property (nonatomic, retain) NSNumber * usersCount;
@property (nonatomic, retain) NSString * venueID;
@property (nonatomic, retain) NSString * venueName;
@property (nonatomic, retain) NSNumber * isFavorite;
@property (nonatomic, retain) NSSet *categories;

@property (nonatomic, retain) Address *address;
@property (nonatomic, retain) Location *location;
@property (nonatomic, retain) VenueInstagramMedia *instagramMedia;
@end

@interface Venue (CoreDataGeneratedAccessors)

- (void)addCategoriesObject:(VenueCategory *)value;
- (void)removeCategoriesObject:(VenueCategory *)value;
- (void)addCategories:(NSSet *)values;
- (void)removeCategories:(NSSet *)values;

-(NSArray *)instagramMediaArray;

@end
