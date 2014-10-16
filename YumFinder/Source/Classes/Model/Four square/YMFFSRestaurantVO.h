//
//  YMFFSRestaurantVO.h
//  YumFinder
//
//  Created by Summer Green on 9/25/14.
//  Copyright (c) 2014 Nimar Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YMFBaseVO.h"

@class YMFFSLocationVO, YMFFSAddressVO;

@interface YMFFSRestaurantVO : YMFBaseVO

@property BOOL hasMenu;
@property BOOL isFavorite;
@property(nonatomic)NSUInteger tipCount;
@property(nonatomic)NSUInteger checkinsCount;
@property(nonatomic)NSUInteger usersCount;

@property(nonatomic, copy)  NSString *venueID;
@property(nonatomic, copy)  NSString *hashTag;
@property(nonatomic, strong)NSString *venueName;
@property(nonatomic, strong)NSString *referralId;
@property(nonatomic, strong)NSArray *media;

/*
 * Here Now
 */
@property unsigned long    countHereNow;
@property(nonatomic, strong)NSArray     *groupsHereNow;
@property(nonatomic, strong)NSString    *summaryHereNow;

/*
 * Special is a dictionary of
 *  - items -> array
 *  - count - integer
 */
@property(nonatomic, strong)NSDictionary *specials;

/*
 * Location
 */

@property(nonatomic, strong)YMFFSLocationVO *location;

/*
 * Address
 */

@property(nonatomic, strong)YMFFSAddressVO *address;


@property(nonatomic, strong)NSArray *categories; //array of YMFFSVenueCategoryVO

@end
