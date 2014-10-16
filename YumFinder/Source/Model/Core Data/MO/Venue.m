#import "Venue.h"
#import "Address.h"
#import "Location.h"
#import "VenueCategory.h"
#import "VenueInstagramMedia.h"
#import "YMFFSRestaurantVO.h"


@implementation Venue

@dynamic checkinsCount;
@dynamic countHereNow;
@dynamic hashTag;
@dynamic media;
@dynamic name;
@dynamic referralId;
@dynamic tipCount;
@dynamic usersCount;
@dynamic venueID;
@dynamic venueName;

@dynamic address;
@dynamic categories;
@dynamic instagramMedia;
@dynamic location;

-(void)initializeFromObject:(YMFFSRestaurantVO*) venue{
    [self setCheckinsCount:@(venue.checkinsCount)];
    [self setCountHereNow:@(venue.countHereNow)];
    [self setHashTag:venue.hashTag];
    [self setName:venue.venueName];
    [self setVenueID:venue.venueID];
}

-(NSArray *)instagramMediaArray{
    VenueInstagramMedia *vim = self.instagramMedia;
    return vim.mediaArray;
}

@end