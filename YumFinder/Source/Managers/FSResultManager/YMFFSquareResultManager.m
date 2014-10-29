//
//  YMFFSquareResultManager.m
//  YumFinder
//
//  Created by Summer Green on 9/25/14.
//  Copyright (c) 2014 Nimar Labs. All rights reserved.
//

#import "YMFFSquareResultManager.h"

#import "NSDictionary+YMF.h"
#import "InstagramKit.h"
#import "Venue.h"
#import "Address.h"
#import "VenueCategory.h"
#import "VenueInstagramMedia.h"
#import "Location.h"

@implementation YMFFSquareResultManager

//-(void)_parseResultFromArray:(NSArray *)array onSuccess:(YMF_SuccessCallback)callback{
//        
//    __block NSMutableArray *mArr = [[NSMutableArray alloc]init];
//    [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
//        YMFFSRestaurantVO *venue = [YMFFSRestaurantVO initWithDictionary:obj];
//        NSString *tag = [[self hashTagWithName:venue] firstObject];
//        [venue setHashTag:tag];
//        [mArr addObject:venue];
//    }];
//    if (callback) {
//        callback(mArr);
//    }
//}

-(void)parseResultFromArray:(NSArray *)array onSuccess:(YMF_SuccessCallback)callback{
    
    [Venue truncateAll];

    [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
        
        Venue *moVenue = [Venue createEntity];
        [moVenue prepareWithDictionary:obj];
   
      /*
         * Category
         */
        
        if(obj[fsCATEGORIES] && [obj[fsCATEGORIES] count]>0){
            for (NSInteger i=0; i<[obj[fsCATEGORIES] count]; i++) {
                VenueCategory *moCate = [VenueCategory createEntity];
                [moCate prepareWithDictionary:obj[fsCATEGORIES][i]];
                [moVenue addCategoriesObject:moCate];
                [moCate setVenue:moVenue];
            }
        }
        
        /*
         * Location
         */
        Location *moLoc = [Location createEntity];
        [moLoc prepareWithDictionary:obj[fsLOCATION]];
        [moLoc setVenue:moVenue];
        [moVenue setLocation:moLoc];
        
        /*
         * Address
         */

        Address *moAdd = [Address createEntity];
        [moAdd prepareWithDictionary:obj[fsLOCATION]];
        [moAdd setVenue:moVenue];
        [moVenue setAddress:moAdd];

        /*
         * VenueInstagramMedia
         */
        VenueInstagramMedia *moInsta = [VenueInstagramMedia createEntity];
        [moInsta setVenue:moVenue];
        [moVenue setInstagramMedia:moInsta];

        
//        [mArr addObject:moVenue];
        
        
//        moInsta = nil;
//        moLoc = nil;
//        moVenue = nil;
//        moAdd = nil;
    }];
    
    [[NSManagedObjectContext defaultContext] saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
        NSLog(@"data saved");
        if (callback) {
            callback(nil);
        }
    }];


    
}




#pragma mark - Instagram
-(void)fetchInstagramImagesForVenue:(Venue *)venue
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
                                                [venue.instagramMedia setMediaArray:media];
                                                [[NSManagedObjectContext defaultContext] saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
                                                    NSLog(@"data saved");
                                                    successCallback(media);;
                                                }];

                                            } failure:^(NSError *error) {
                                                NSLog(@"Search Media Failed");
                                            }];
}

#pragma mark - Core Data Methods

-(void)save{
    // Save Managed Object Context
    [[NSManagedObjectContext defaultContext] saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
        NSLog(@"data saved");
    }];
}
@end
