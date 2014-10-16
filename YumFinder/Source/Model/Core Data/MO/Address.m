//
//  Address.m
//  YumFinder
//
//  Created by Gaurav Keshre on 10/12/14.
//  Copyright (c) 2014 Nimar Labs. All rights reserved.
//

#import "Address.h"
#import "Venue.h"
#import "YMFFSAddressVO.h"


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

-(void)initializeFromObject:(YMFFSAddressVO *)address{
    [self setCc:address.cc];
    [self setCity:address.city];
    [self setCountry:address.country];
    [self setFormalAddress:address.formalAddress];
    [self setPostalCode:address.postalCode];
    [self setState:address.state];
    [self setStreetAddress:address.streetAddress];
}
@end
