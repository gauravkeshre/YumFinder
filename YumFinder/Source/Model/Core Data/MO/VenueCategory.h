//
//  VenueCategory.h
//  YumFinder
//
//  Created by Green Summer on 10/12/14.
//  Copyright (c) 2014 Nimar Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "NLS_BaseManagedObject.h"
@class Venue;
@class YMFFSVenueCategoryVO;

@interface VenueCategory : NLS_BaseManagedObject

@property (nonatomic, retain) NSString * categoryID;
@property (nonatomic, retain) NSString * categoryName;
@property (nonatomic, retain) NSString * pluralName;
@property (nonatomic, retain) NSString * prefix;
@property (nonatomic, retain) NSString * shortName;
@property (nonatomic, retain) NSString * suffix;
@property (nonatomic, retain) NSNumber * isPrimary;
@property (nonatomic, retain) Venue *venue;


-(NSString *)iconURLWithSize:(NSUInteger)size;
@end
