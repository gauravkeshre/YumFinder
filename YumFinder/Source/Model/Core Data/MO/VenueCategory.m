//
//  VenueCategory.m
//  YumFinder
//
//  Created by Green Summer on 10/12/14.
//  Copyright (c) 2014 Nimar Labs. All rights reserved.
//

#import "VenueCategory.h"
#import "Venue.h"



@implementation VenueCategory

@dynamic categoryID;
@dynamic categoryName;
@dynamic pluralName;
@dynamic prefix;
@dynamic shortName;
@dynamic suffix;
@dynamic venue;
@dynamic isPrimary;

-(void)prepareWithDictionary:(NSDictionary *)d{
    
    [self setPluralName:d[fsPLURALNAME]];
    [self setIsPrimary:@([d[fsPRIMARY] boolValue])];
    [self setCategoryID:d[fsID]];
    [self setShortName:d[fsSHORTNAME]];
    [self setCategoryName:d[fsNAME]];
    [self setPrefix:d[fsICON][fsPREFIX]];
    [self setSuffix:d[fsICON][fsSUFFIX]];
}

-(NSString *)iconURLWithSize:(NSUInteger)size{
    return [NSString stringWithFormat:@"%@%lu%@", self.prefix, (unsigned long)size, self.suffix];
}

@end
