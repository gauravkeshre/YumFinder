//
//  Venue.h
//  YumFinder
//
//  Created by Gaurav Keshre on 10/15/14.
//  Copyright (c) 2014 Nimar Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Address, Location, VenueCategory, VenueInstagramMedia;
@class YMFFSRestaurantVO;
@interface Venue : NSManagedObject

@property (nonatomic, retain) NSNumber * checkinsCount;
@property (nonatomic, retain) NSNumber * countHereNow;
@property (nonatomic, retain) NSString * hashTag;
@property (nonatomic, retain) NSString * media;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * referralId;
@property (nonatomic, retain) NSNumber * tipCount;
@property (nonatomic, retain) NSNumber * usersCount;
@property (nonatomic, retain) NSString * venueID;
@property (nonatomic, retain) NSString * venueName;
@property (nonatomic, retain) Address *address;
@property (nonatomic, retain) NSSet *categories;
@property (nonatomic, retain) VenueInstagramMedia *instagramMedia;
@property (nonatomic, retain) Location *location;


- (NSArray *)instagramMediaArray;

@end

@interface Venue (CoreDataGeneratedAccessors)

- (void)addCategoriesObject:(VenueCategory *)value;
- (void)removeCategoriesObject:(VenueCategory *)value;
- (void)addCategories:(NSSet *)values;
- (void)removeCategories:(NSSet *)values;

- (void)initializeFromObject:(YMFFSRestaurantVO*) venue;

@end
