//
//  VenueCategory.m
//  YumFinder
//
//  Created by Gaurav Keshre on 10/12/14.
//  Copyright (c) 2014 Nimar Labs. All rights reserved.
//

#import "VenueCategory.h"
#import "Venue.h"
#import "YMFFSVenueCategoryVO.h"


@implementation VenueCategory

@dynamic categoryID;
@dynamic categoryName;
@dynamic pluralName;
@dynamic prefix;
@dynamic shortName;
@dynamic suffix;
@dynamic venue;

-(void)setCategoryFrom:(YMFFSVenueCategoryVO *) category{
    self.categoryID = category.categoryID;
    self.categoryName = category.categoryName;
    self.prefix = category.prefix;
    self.shortName =category.shortName;
    self.suffix = category.suffix;
}
@end
