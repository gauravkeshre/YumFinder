//
//  YMFFSquareResultManager.h
//  YumFinder
//
//  Created by Summer Green on 9/25/14.
//  Copyright (c) 2014 Nimar Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Venue;

@interface YMFFSquareResultManager : NSObject

-(void)parseResultFromArray:(NSArray *)array onSuccess:(YMF_SuccessCallback)callback;

#pragma mark - Instagram

-(void)fetchInstagramImagesForVenue:(Venue *)venue
                       withCallBack:(YMF_SuccessCallback)successCallback
                          onFailure:(YMF_SuccessCallback)failureBlock;
@end
