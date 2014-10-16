//
//  YMFImagesFromHashtagOperation.h
//  YumFinder
//
//  Created by Gaurav Keshre on 10/6/14.
//  Copyright (c) 2014 Nimar Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YMFImagesFromHashtagOperation : NSOperation

@property(nonatomic, readonly, strong)NSString *hashtag;
@property(nonatomic, readonly, strong)NSString *venueID;

-(instancetype)initWithHashTag:(NSString *)hashTag andVenueID:(NSString *)venue_id;
@end
