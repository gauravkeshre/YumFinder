//
//  Address.m
//  YumFinder
//
//  Created by Green Summer on 10/12/14.
//  Copyright (c) 2014 Nimar Labs. All rights reserved.
//

#import "Address.h"
#import "Venue.h"



@implementation Address

@dynamic cc;
@dynamic city;
@dynamic country;
@dynamic crossStreet;
@dynamic formalAddress;
@dynamic postalCode;
@dynamic state;
@dynamic streetAddress;
@dynamic venue;


-(void)prepareWithDictionary:(NSDictionary *)d{

    [self setCity:d[fsCITY]];
    [self setCc:d[fsCC]];
    [self setCountry:d[fsCOUNTRY]];
    [self setState:d[fsSTATE]];
    [self setPostalCode:d[fsPOSTALCODE]];
    [self setCrossStreet:d[fsCROSSSTREET]];
    [self setStreetAddress:d[fsADDRESS]];
    [self setFormalAddress:[d[fsFORMATTEDADDRESS] componentsJoinedByString:@",\n"]];
}

@end
