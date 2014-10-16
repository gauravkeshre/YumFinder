//
//  VenueCategory.h
//  YumFinder
//
//  Created by Gaurav Keshre on 10/12/14.
//  Copyright (c) 2014 Nimar Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Venue;
@class YMFFSVenueCategoryVO;

@interface VenueCategory : NSManagedObject

@property (nonatomic, retain) NSString * categoryID;
@property (nonatomic, retain) NSString * categoryName;
@property (nonatomic, retain) NSString * pluralName;
@property (nonatomic, retain) NSString * prefix;
@property (nonatomic, retain) NSString * shortName;
@property (nonatomic, retain) NSString * suffix;
@property (nonatomic, retain) Venue *venue;

-(void)setCategoryFrom:(YMFFSVenueCategoryVO *) category;
@end
