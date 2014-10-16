//
//  YMFFSquareResultManager.m
//  YumFinder
//
//  Created by Summer Green on 9/25/14.
//  Copyright (c) 2014 Nimar Labs. All rights reserved.
//

#import "YMFFSquareResultManager.h"

#import "NSDictionary+YMF.h"
#import "YMFFSRestaurantVO.h"
#import "YMFFSAddressVO.h"
#import "YMFFSLocationVO.h"
#import "InstagramKit.h"

@implementation YMFFSquareResultManager

-(void)parseResultFromArray:(NSArray *)array onSuccess:(YMF_SuccessCallback)callback{
        
    __block NSMutableArray *mArr = [[NSMutableArray alloc]init];
    [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
        YMFFSRestaurantVO *venue = [YMFFSRestaurantVO initWithDictionary:obj];
        NSString *tag = [[self hashTagWithName:venue] firstObject];
        [venue setHashTag:tag];
        [mArr addObject:venue];
    }];
    if (callback) {
        callback(mArr);
    }
}

-(NSArray *)hashTagWithName:(YMFFSRestaurantVO * )venue{
    
    NSCharacterSet *charactersToRemove = [[NSCharacterSet alphanumericCharacterSet] invertedSet];

//    NSString *str2 = [[venue.venueName stringByReplacingOccurrencesOfString:@" " withString:@""] stringByTrimmingCharactersInSet:charactersToRemove];
    NSString *trimmedReplacement = [[[venue.venueName stringByReplacingOccurrencesOfString:@" " withString:@""] componentsSeparatedByCharactersInSet:charactersToRemove] componentsJoinedByString:@""];

    
    return @[trimmedReplacement];//[set allObjects];
}



#pragma mark - Instagram
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
                                                NSLog(@"Search Media for: %@ \n Media: %@", venue.hashTag,media);
                                                venue.media = media;
                                                successCallback(media);
                                            } failure:^(NSError *error) {
                                                NSLog(@"Search Media Failed");
                                            }];
}

@end
