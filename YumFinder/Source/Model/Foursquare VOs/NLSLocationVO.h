//
//  NLSLocationVO.h
//  Restaurage
//
//  Created by Summer Green on 9/19/14.
//  Copyright (c) 2014 Nimar Labs Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 * location":{
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
 }
 */
@interface NLSLocationVO : NSObject
@property CGFloat *distance;
@property(nonatomic, strong) NSString *city;
@property(nonatomic, strong) NSString *cc;
@property(nonatomic, strong) NSString *country;
@property(nonatomic, strong) NSString *postalCode;
@property(nonatomic, strong) NSString *state;
@property(nonatomic, strong) NSArray *formalAddress;
@property(nonatomic, strong) NSString *crossStreet;
@property(nonatomic, strong) NSString *address;
@property(nonatomic) CGFloat latitude;
@property(nonatomic) CGFloat longitude;


@end
