//
//  NLSFSVenueVO.h
//  Restaurage
//
//  Created by Summer Green on 9/19/14.
//  Copyright (c) 2014 Nimar Labs Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 {
 "hasMenu":true,
 "stats":{},
 "name":"Shinju Sushi",
 "referralId":"v-1410801434",
 "hereNow":{},
 "specials":{
 "count":0,
 "items":[
 ]
 },
 "location":{
 "distance":920,
 "city":"New York",
 "cc":"US",
 "country":"United States",
 "postalCode":10005,
 "state":"NY",
 "formattedAddress":[
 "164 Pearl St (btwn Pine & Wall St.)",
 "New York, NY 10005",
 "United States"
 ],
 "crossStreet":"btwn Pine & Wall St.",
 "address":"164 Pearl St",
 "lat":40.706062690550382,
 "lng":-74.007424315569992
 },
 "verified":false,
 "id":"4a5e00d9f964a520e2bd1fe3",
 "categories":[
 {
 "pluralName":"Sushi Restaurants",
 "primary":true,
 "name":"Sushi Restaurant",
 "shortName":"Sushi",
 "id":"4bf58dd8d48988d1d2941735",
 "icon":{
 "prefix":"https://ss1.4sqi.net/img/categories_v2/food/sushi_",
 "suffix":".png"
 }
 }
 ]
 },
 */

@class NLSLocationVO;
@interface NLSFSVenueVO : NSObject

@property(nonatomic)BOOL hasMenu, verified;
@property(nonatomic, strong)NSArray *stats, *categories;
@property(nonatomic, strong)NLSLocationVO *location;
@property(nonatomic, strong)NSString *name;
@property(nonatomic, strong)NSString *venueID;
@property(nonatomic, strong)NSString *referralID;

-(NSString *)iconImageForCategoryAtIndex:(NSUInteger)index withSize:(CGFloat)size;
@end
