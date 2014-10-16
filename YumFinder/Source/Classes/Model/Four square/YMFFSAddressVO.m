//
//  YMFFSAddressVO.m
//  YumFinder
//
//  Created by Summer Green on 9/25/14.
//  Copyright (c) 2014 Nimar Labs. All rights reserved.
//

#import "YMFFSAddressVO.h"

@implementation YMFFSAddressVO

+(instancetype)initWithDictionary:(NSDictionary *)d{
    YMFFSAddressVO *address = [YMFFSAddressVO new];
    [address setCity:d[fsCITY]];
    [address setCc:d[fsCC]];
    [address setCountry:d[fsCOUNTRY]];
    [address setState:d[fsSTATE]];
    [address setPostalCode:d[fsPOSTALCODE]];
    [address setCrossStreet:d[fsCROSSSTREET]];
    [address setStreetAddress:d[fsADDRESS]];
    [address setFormalAddress:[d[fsFORMATTEDADDRESS] componentsJoinedByString:@",\n"]];
    return address;
}

@end


/*
 * location":{
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
 },
 */