//
//  YMFAPIManager.h
//  YumFinder
//
//  Created by Gaurav Keshre on 9/22/14.
//  Copyright (c) 2014 Nimar Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MYProtocol<NSObject>
//required and optional method
@end


@interface YMFAPIManager : NSObject <BZFoursquareRequestDelegate, BZFoursquareSessionDelegate>

@property(nonatomic, copy)YMF_SuccessCallback successCallback;
@property(nonatomic, copy)YMF_FailureCallback failureCallback;

@property(nonatomic, weak)id<MYProtocol>delegate;
@property(nonatomic,readonly,strong) BZFoursquare *foursquare;

+(void)startSearchForRestaurantsThatServe:(NSString *)cuisine
                                   within:(CGFloat)diameter
                             onCompletion:(YMF_SuccessCallback)successCallback
                                onFailure:(YMF_FailureCallback)successCallback;

@end
