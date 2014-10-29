//
//  Venue.m
//  YumFinder
//
//  Created by Green Summer on 10/17/14.
//  Copyright (c) 2014 Nimar Labs. All rights reserved.
//

#import "Venue.h"
#import "Address.h"
#import "Location.h"
#import "VenueCategory.h"
#import "VenueInstagramMedia.h"



@implementation Venue

@dynamic checkinsCount;
@dynamic countHereNow;
@dynamic hashTag;
@dynamic name;
@dynamic referralId;
@dynamic tipCount;
@dynamic usersCount;
@dynamic venueID;
@dynamic venueName;
@dynamic isFavorite;
@dynamic address;
@dynamic categories;
@dynamic instagramMedia;
@dynamic location;

-(NSArray *)instagramMediaArray{
    VenueInstagramMedia *vim = self.instagramMedia;
    return vim.mediaArray;
}

-(void)prepareWithDictionary:(NSDictionary *)d{
    
    [self setVenueID:d[fsID]];
    [self setVenueName:d[fsNAME]];
    [self setReferralId:d[fsREFERRALID]];
    [self setCountHereNow:@([d[fsHERENOW][fsCOUNT] unsignedLongValue])];
    NSString *ht = [[self hashTagsWithName:d[fsNAME]] firstObject];
    if (ht) {
            [self setHashTag:ht];
    }

    
    /*
     * Location
     * Address
     * Categories
     -- These will be added seperately
     */
}
#pragma mark - Helper Methods
-(NSArray *)hashTagsWithName:(NSString * )venueName{
    
    NSCharacterSet *charactersToRemove = [[NSCharacterSet alphanumericCharacterSet] invertedSet];
    
    NSString *trimmedReplacement = [[[venueName stringByReplacingOccurrencesOfString:@" " withString:@""] componentsSeparatedByCharactersInSet:charactersToRemove] componentsJoinedByString:@""];
    
    
    return @[trimmedReplacement];//[set allObjects];
}

@end
