//
//  YMFImagesFromHashtagOperation.m
//  YumFinder
//
//  Created by Gaurav Keshre on 10/6/14.
//  Copyright (c) 2014 Nimar Labs. All rights reserved.
//

#import "YMFImagesFromHashtagOperation.h"
#import "InstagramEngine.h"
#import "YMFFSRestaurantVO.h"

@interface YMFImagesFromHashtagOperation()
@property(nonatomic, readwrite, strong)NSString *hashtag;
@property(nonatomic, readwrite, strong)NSString *venueID;

@end
@implementation YMFImagesFromHashtagOperation
-(instancetype)initWithHashTag:(NSString *)hashTag andVenueID:(NSString *)venue_id{
    self = [super init];
    if (self) {
        self.hashtag = hashTag;
        self.venueID = venue_id;
    }
    return self;
}



-(void)main{
    @autoreleasepool {
        if (self.isCancelled) {
            return;
        }
        
        
        
        
    }
}
#pragma mark - Instagram Methods
-(void)fetchInstagramImagesForVenue:(YMFFSRestaurantVO *)venue
                       withCallBack:(YMF_SuccessCallback)successCallback
                          onFailure:(YMF_SuccessCallback)failureBlock{
    if(venue.hashTag.length <1 ){
        successCallback = nil;
        if (failureBlock) {
            failureBlock(@"No hashtags for the venue.");
        }
        return;
    }
    [[InstagramEngine sharedEngine] getMediaWithTagName:venue.hashTag
                                                  count:15
                                                  maxId:nil
                                            withSuccess:^(NSArray *media, InstagramPaginationInfo *paginationInfo) {
                                                NSLog(@"Search Media FOUND ****: %@", media);
                                                venue.media = media;
                                                successCallback(media);
                                            } failure:^(NSError *error) {
                                                NSLog(@"Search Media Failed");
                                            }];
}

@end
